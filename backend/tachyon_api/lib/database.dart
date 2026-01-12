
import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';

class DatabaseClient {

  factory DatabaseClient() => initialize();
  DatabaseClient._(this._connection);

  static DatabaseClient? _instance;
  final Pool _connection;

  static DatabaseClient initialize() {
    if (_instance != null) return _instance!;

    final env = DotEnv()..load();

    final host = env['DB_HOST'] ?? 'localhost';
    final port = int.tryParse(env['DB_PORT'] ?? '5432') ?? 5432;
    final database = env['DB_NAME'] ?? 'postgres';
    final user = env['DB_USER'] ?? 'postgres';
    final password = env['DB_PASSWORD'] ?? 'password';

    final endpoint = Endpoint(
      host: host,
      port: port,
      database: database,
      username: user,
      password: password,
    );

    final connection = Pool.withEndpoints(
      [endpoint],
      settings: const PoolSettings(sslMode: SslMode.disable),
    );

    _instance = DatabaseClient._(connection);
    return _instance!;
  }

  Pool get connection => _connection;

  Future<void> close() async {
    await _connection.close();
    _instance = null;
  }
}
