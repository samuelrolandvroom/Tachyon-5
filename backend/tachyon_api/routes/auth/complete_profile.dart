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

    // Social data from previous step
    final socialData = body['socialData'] as Map<String, dynamic>?;

    // Required profile fields
    final username = body['username'] as String?;
    final firstName = body['firstName'] as String?;
    final lastName = body['lastName'] as String?;
    final password = body['password']
        as String?; // Optional: Social users might not need a password, but we'll allow it.

    // Other optional fields
    final middleName = body['middleName'] as String?;
    final phoneNumber = body['phoneNumber'] as String?;
    final profilePhoto = body['profilePhoto'] as String?;
    final bio = body['bio'] as String?;

    if (socialData == null ||
        username == null ||
        firstName == null ||
        lastName == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'error':
              'Missing required fields: socialData, username, firstName, lastName'
        },
      );
    }

    final provider = socialData['provider'] as String?;
    final providerUserId = socialData['providerUserId'] as String?;
    final socialEmail = socialData['email'] as String?;

    if (provider == null || providerUserId == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': 'Invalid socialData structure'},
      );
    }

    final userRepo = context.read<UserRepository>();
    final authService = context.read<AuthService>();

    // 1. Check if username is taken
    final existingUserByUsername = await userRepo.findUserByUsername(username);
    if (existingUserByUsername != null) {
      return Response.json(
        statusCode: HttpStatus.conflict,
        body: {'error': 'Username already taken'},
      );
    }

    // 2. Create User
    // For social users, the primary email is usually the social email.
    // We use a random hash for password if one isn't provided (since they log in via social).
    final hashedPassword = authService.hashPassword(
        password ?? 'social_login_${DateTime.now().millisecondsSinceEpoch}');

    await userRepo.createUser(
      username: username,
      email: socialEmail ??
          '$username@social.placeholder', // Fallback if no email from social
      passwordHash: hashedPassword,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      profilePhoto: profilePhoto,
      bio: bio,
    );

    // 3. Link Social Account
    final newUser = await userRepo.findUserByUsername(username);
    final userId = newUser!['id'] as String;

    await userRepo.linkSocialAccount(
      userId: userId,
      provider: provider,
      providerUserId: providerUserId,
      email: socialEmail,
    );

    // 4. Return JWT
    final jwtToken = authService.generateToken(userId);

    return Response.json(
      statusCode: HttpStatus.created,
      body: {
        'token': jwtToken,
        'user': {
          'id': userId,
          'username': username,
          'email': socialEmail,
          'firstName': firstName,
          'lastName': lastName,
        }
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {'error': e.toString()},
    );
  }
}
