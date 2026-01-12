class SocialToken {
  SocialToken({
    required this.provider,
    required this.providerUserId,
    this.email,
    this.name,
  });

  final String provider;
  final String providerUserId;
  final String? email;
  final String? name;
}

class SocialTokenVerifier {
  /// Verifies a social token.
  /// For development, it supports mock tokens in the format:
  /// `mock_{provider}_{id}` (e.g., `mock_google_123`)
  Future<SocialToken?> verify(String provider, String token) async {
    if (token.startsWith('mock_${provider}_')) {
      final id = token.replaceFirst('mock_${provider}_', '');
      return SocialToken(
        provider: provider,
        providerUserId: id,
        email: '$id@example.com',
        name: 'Mock User $id',
      );
    }

    // TODO: Implement real verification logic for Google, Apple, etc.
    // For Google: final payload = await GoogleIdTokenVerifier.verify(token, clientId);
    // For Apple: final payload = await AppleIdTokenVerifier.verify(token, clientId);

    return null;
  }
}
