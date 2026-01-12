
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tachyon_api/auth_service.dart';
import 'package:tachyon_api/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  // 1. Verify Authentication (Local Middleware Logic)
  final authService = context.read<AuthService>();
  final authHeader = context.request.headers['Authorization'];
  
  if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      return Response(statusCode: HttpStatus.unauthorized);
  }
  
  final token = authHeader.substring(7);
  final payload = authService.verifyToken(token);
  
  if (payload == null) {
      return Response(statusCode: HttpStatus.unauthorized);
  }

  // 2. Fetch User Profile
  final userId = payload['id'] as String;
  final userRepo = context.read<UserRepository>();
  
  try {
    final user = await userRepo.findUserById(userId);
    if (user == null) {
        return Response(statusCode: HttpStatus.notFound);
    }

    // Don't return the password hash!
    user.remove('password_hash');

    return Response.json(body: user);
  } catch (e) {
      return Response.json(statusCode: HttpStatus.internalServerError, body: {'error': e.toString()});
  }
}
