import 'package:tachyon_core/tachyon_core.dart';
import 'api_client.dart';

class AuthRepository {
  AuthRepository(this._client);

  final ApiClient _client;

  Future<AuthResponse> login(String identifier, String password) async {
    final data = await _client.post('/auth/login', {
      'identifier': identifier,
      'password': password,
    });
    final response = AuthResponse.fromJson(data);
    _client.setToken(response.token);
    return response;
  }

  Future<AuthResponse> signup({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    final data = await _client.post('/auth/signup', {
      'email': email,
      'password': password,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
    });
    final response = AuthResponse.fromJson(data);
    _client.setToken(response.token);
    return response;
  }

  Future<SocialAuthResponse> socialLogin(String provider, String token) async {
    final data = await _client.post('/auth/social/login', {
      'provider': provider,
      'token': token,
    });
    final response = SocialAuthResponse.fromJson(data);
    if (response.token != null) {
      _client.setToken(response.token);
    }
    return response;
  }

  Future<AuthResponse> completeProfile({
    required Map<String, dynamic> socialData,
    required String username,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    final data = await _client.post('/auth/complete_profile', {
      'socialData': socialData,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    });
    final response = AuthResponse.fromJson(data);
    _client.setToken(response.token);
    return response;
  }

  void logout() {
    _client.setToken(null);
  }
}
