import 'package:dart_frog/dart_frog.dart';
import 'package:tachyon_api/auth_service.dart';
import 'package:tachyon_api/database.dart';
import 'package:tachyon_api/user_repository.dart';

Handler middleware(Handler handler) {
  final dbClient = DatabaseClient();
  final authService = AuthService();
  final userRepository = UserRepository(dbClient);

  return handler
      .use(_corsMiddleware())
      .use(_provider<DatabaseClient>(() => dbClient))
      .use(_provider<AuthService>(() => authService))
      .use(_provider<UserRepository>(() => userRepository));
}

Middleware _corsMiddleware() {
  return (handler) {
    return (context) async {
      // Handle preflight requests
      if (context.request.method == HttpMethod.options) {
        return Response(
          statusCode: 204,
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers':
                'Origin, Content-Type, Authorization',
          },
        );
      }

      final response = await handler(context);

      // Add CORS headers to all responses
      return response.copyWith(
        headers: {
          ...response.headers,
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
        },
      );
    };
  };
}

Middleware _provider<T>(T Function() create) {
  return (Handler handler) {
    return (RequestContext context) {
      return handler(
        context.provide<T>(() => create()),
      );
    };
  };
}
