
import 'package:bcrypt/bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';

class AuthService {
  AuthService() {
    final env = DotEnv()..load();
    _secretKey = env['JWT_SECRET'] ?? 'default_secret_key_change_me';
  }

  late final String _secretKey;

  /// Hashes a plain text password.
  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  /// Verifies a password against a hash.
  bool verifyPassword(String password, String hash) {
    return BCrypt.checkpw(password, hash);
  }

  /// Generates a JWT for a given user ID.
  String generateToken(String userId) {
    final jwt = JWT({
      'id': userId,
      'createdAt': DateTime.now().toIso8601String(),
    });

    return jwt.sign(SecretKey(_secretKey));
  }

  /// Verifies a JWT and returns the payload or null if invalid.
  Map<String, dynamic>? verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_secretKey));
      return jwt.payload as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
}
