import 'package:dart_frog/dart_frog.dart';
import 'package:tachyon_api/auth_service.dart';
import 'package:tachyon_api/database.dart';
import 'package:tachyon_api/user_repository.dart';

Handler middleware(Handler handler) {
  final dbClient = DatabaseClient();
  final authService = AuthService();
  final userRepository = UserRepository(dbClient);

  return handler
      .use(_provider<DatabaseClient>(() => dbClient))
      .use(_provider<AuthService>(() => authService))
      .use(_provider<UserRepository>(() => userRepository));
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
