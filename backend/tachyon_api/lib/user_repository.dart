import 'package:postgres/postgres.dart';
import 'package:tachyon_api/database.dart';

class UserRepository {
  UserRepository(this._db);

  final DatabaseClient _db;

  Future<void> createUser({
    required String username,
    required String email,
    required String passwordHash,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? middleName,
    String? profilePhoto,
    String? bio,
  }) async {
    await _db.connection.execute(
      Sql.named(
        'INSERT INTO users (id, username, email, phone_number, password_hash, first_name, middle_name, last_name, profile_photo, bio, created_at, updated_at) '
        'VALUES (gen_random_uuid(), @username, @email, @phoneNumber, @passwordHash, @firstName, @middleName, @lastName, @profilePhoto, @bio, NOW(), NOW())',
      ),
      parameters: {
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'passwordHash': passwordHash,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'profilePhoto': profilePhoto,
        'bio': bio,
      },
    );
  }

  Future<Map<String, dynamic>?> findUserByIdentifier(String identifier) async {
    final result = await _db.connection.execute(
      Sql.named(
        'SELECT * FROM users WHERE email = @identifier OR username = @identifier OR phone_number = @identifier',
      ),
      parameters: {'identifier': identifier},
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return row.toColumnMap();
  }

  Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    final result = await _db.connection.execute(
      Sql.named('SELECT * FROM users WHERE email = @email'),
      parameters: {'email': email},
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return row.toColumnMap();
  }

  Future<Map<String, dynamic>?> findUserByUsername(String username) async {
    final result = await _db.connection.execute(
      Sql.named('SELECT * FROM users WHERE username = @username'),
      parameters: {'username': username},
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return row.toColumnMap();
  }

  Future<Map<String, dynamic>?> findUserById(String id) async {
    final result = await _db.connection.execute(
      Sql.named('SELECT * FROM users WHERE id = @id'),
      parameters: {'id': id},
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return row.toColumnMap();
  }

  Future<Map<String, dynamic>?> findUserBySocialProvider(
      String provider, String providerUserId) async {
    final result = await _db.connection.execute(
      Sql.named(
        'SELECT u.* FROM users u '
        'JOIN social_accounts s ON u.id = s.user_id '
        'WHERE s.provider = @provider AND s.provider_user_id = @providerUserId',
      ),
      parameters: {
        'provider': provider,
        'providerUserId': providerUserId,
      },
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return row.toColumnMap();
  }

  Future<void> linkSocialAccount({
    required String userId,
    required String provider,
    required String providerUserId,
    String? email,
  }) async {
    await _db.connection.execute(
      Sql.named(
        'INSERT INTO social_accounts (id, user_id, provider, provider_user_id, email, created_at) '
        'VALUES (gen_random_uuid(), @userId, @provider, @providerUserId, @email, NOW())',
      ),
      parameters: {
        'userId': userId,
        'provider': provider,
        'providerUserId': providerUserId,
        'email': email,
      },
    );
  }
}
