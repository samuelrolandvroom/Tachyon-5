import 'package:riverpod/riverpod.dart';
import 'api_client.dart';
import 'auth_repository.dart';

final apiBaseUrlProvider =
    Provider<String>((ref) => throw UnimplementedError());

final apiClientProvider = Provider<ApiClient>((ref) {
  final baseUrl = ref.watch(apiBaseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return AuthRepository(client);
});
