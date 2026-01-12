import 'dart:io';
import 'package:tachyon_api/database.dart'; // Adjust path if needed

void main() async {
  print('Initializing database schema...');

  final dbClient = DatabaseClient.initialize();
  final connection = dbClient.connection;

  final sql = File('scripts/init_db.sql').readAsStringSync();

  try {
    await connection.execute(sql);
    print('Database schema initialized successfully.');
  } catch (e) {
    print('Error initializing database: $e');
  } finally {
    await dbClient.close();
  }
}
