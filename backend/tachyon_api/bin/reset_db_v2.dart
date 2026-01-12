import 'dart:io';
import 'package:tachyon_api/database.dart';

void main() async {
  print('Resetting database for Social Login...');

  final dbClient = DatabaseClient.initialize();
  final connection = dbClient.connection;

  try {
    print('Dropping tables...');
    await connection.execute('DROP TABLE IF EXISTS social_accounts');
    await connection.execute('DROP TABLE IF EXISTS users');

    print('Initializing database schema...');
    final sql = File('scripts/init_db.sql').readAsStringSync();
    for (final statement in sql.split(';')) {
      if (statement.trim().isNotEmpty) {
        await connection.execute(statement);
      }
    }

    print('Database reset successfully.');
  } catch (e) {
    print('Error resetting database: $e');
  } finally {
    await dbClient.close();
  }
}
