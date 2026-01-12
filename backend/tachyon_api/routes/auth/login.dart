import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tachyon_api/auth_service.dart';
import 'package:tachyon_api/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  try {
    final body = await context.request.json() as Map<String, dynamic>;
    // Allow 'identifier' or fall back to 'email'
    final identifier =
        body['identifier'] as String? ?? body['email'] as String?;
    final password = body['password'] as String?;

    if (identifier == null || password == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'error': 'Missing required fields: identifier (or email), password',
        },
      );
    }

    final userRepo = context.read<UserRepository>();
    final authService = context.read<AuthService>();

    final user = await userRepo.findUserByIdentifier(identifier);
    if (user == null) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {'error': 'Invalid credentials'},
      );
    }

    final isValid =
        authService.verifyPassword(password, user['password_hash'] as String);
    if (!isValid) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {'error': 'Invalid credentials'},
      );
    }

    final token = authService.generateToken(user['id'] as String);

    return Response.json(
      body: {
        'token': token,
        'user': {
          'id': user['id'],
          'username': user['username'],
          'email': user['email'],
          'phoneNumber': user['phone_number'],
          'firstName': user['first_name'],
          'middleName': user['middle_name'],
          'lastName': user['last_name'],
          'profilePhoto': user['profile_photo'],
          'bio': user['bio'],
        },
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {'error': e.toString()},
    );
  }
}
