import 'package:dart_frog/dart_frog.dart';
import 'package:tachyon_api/database.dart';

Future<Response> onRequest(RequestContext context) async {
  final dbClient = context.read<DatabaseClient>();

  try {
    final result = await dbClient.connection.execute('SELECT 1');
    return Response.json(body: {
      'status': 'ok',
      'database': 'connected',
      'result': result.first[0],
    },);
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {
        'status': 'error',
        'database': 'disconnected',
        'error': e.toString(),
      },
    );
  }
}
