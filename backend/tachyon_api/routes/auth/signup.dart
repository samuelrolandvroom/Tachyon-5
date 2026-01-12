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

    return Response.json(
      statusCode: HttpStatus.created,
      body: {'message': 'User created successfully'},
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {'error': e.toString()},
    );
  }
}
