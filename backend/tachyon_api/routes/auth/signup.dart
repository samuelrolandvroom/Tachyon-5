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
    final email = body['email'] as String?;
    final password = body['password'] as String?;
    final firstName = body['firstName'] as String?;
    final middleName = body['middleName'] as String?;
    final lastName = body['lastName'] as String?;
    final username = body['username'] as String?;
    final phoneNumber = body['phoneNumber'] as String?;

    if (email == null ||
        password == null ||
        firstName == null ||
        lastName == null ||
        username == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'error':
              'Missing required fields: email, password, firstName, lastName, username',
        },
      );
    }

    final userRepo = context.read<UserRepository>();
    final authService = context.read<AuthService>();

    // Check if user exists (email or username)
    final existingUserByEmail = await userRepo.findUserByEmail(email);
    if (existingUserByEmail != null) {
      return Response.json(
        statusCode: HttpStatus.conflict,
        body: {'error': 'User with this email already exists'},
      );
    }

    final existingUserByUsername = await userRepo.findUserByUsername(username);
    if (existingUserByUsername != null) {
      return Response.json(
        statusCode: HttpStatus.conflict,
        body: {'error': 'User with this username already exists'},
      );
    }

    // Check phone number if provided
    if (phoneNumber != null) {
      final existingUserByPhone =
          await userRepo.findUserByIdentifier(phoneNumber);
      if (existingUserByPhone != null) {
        return Response.json(
          statusCode: HttpStatus.conflict,
          body: {'error': 'User with this phone number already exists'},
        );
      }
    }

    // Hash password & Create user
    final hashedPassword = authService.hashPassword(password);
    await userRepo.createUser(
      email: email,
      passwordHash: hashedPassword,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      username: username,
      phoneNumber: phoneNumber,
    );

    // Fetch the newly created user to return full profile
    final user = await userRepo.findUserByEmail(email);
    if (user == null) {
      throw Exception('Failed to fetch user after creation');
    }

    final token = authService.generateToken(user['id'] as String);

    return Response.json(
      statusCode: HttpStatus.created,
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
          'createdAt': (user['created_at'] as DateTime).toIso8601String(),
          'updatedAt': (user['updated_at'] as DateTime).toIso8601String(),
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
