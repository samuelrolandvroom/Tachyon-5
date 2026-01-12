import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:tachyon_api/auth_service.dart';
import 'package:tachyon_api/user_repository.dart';
import 'package:tachyon_api/social_token_verifier.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final provider = body['provider'] as String?;
    final token = body['token'] as String?;

    if (provider == null || token == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': 'Missing required fields: provider, token'},
      );
    }

    final verifier = SocialTokenVerifier();
    final socialInfo = await verifier.verify(provider, token);

    if (socialInfo == null) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {'error': 'Invalid social token'},
      );
    }

    final userRepo = context.read<UserRepository>();
    final authService = context.read<AuthService>();

    final user = await userRepo.findUserBySocialProvider(
      socialInfo.provider,
      socialInfo.providerUserId,
    );

    if (user != null) {
      // User found, log them in
      final jwtToken = authService.generateToken(user['id'] as String);
      return Response.json(
        body: {
          'isProfileComplete': true,
          'token': jwtToken,
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
            'createdAt': (user['created_at'] as DateTime).toIso8601String(),
            'updatedAt': (user['updated_at'] as DateTime).toIso8601String(),
          }
        },
      );
    } else {
      // User not found, return "incomplete" status for profile completion
      return Response.json(
        body: {
          'isProfileComplete': false,
          'socialData': {
            'provider': socialInfo.provider,
            'providerUserId': socialInfo.providerUserId,
            'email': socialInfo.email,
            'name': socialInfo.name,
          }
        },
      );
    }
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {'error': e.toString()},
    );
  }
}
