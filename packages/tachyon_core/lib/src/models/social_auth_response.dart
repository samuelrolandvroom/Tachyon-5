import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'social_auth_response.freezed.dart';
part 'social_auth_response.g.dart';

@freezed
class SocialAuthResponse with _$SocialAuthResponse {
  const factory SocialAuthResponse({
    required String status, // 'complete' or 'incomplete'
    String? token,
    User? user,
    Map<String, dynamic>? socialData,
  }) = _SocialAuthResponse;

  factory SocialAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$SocialAuthResponseFromJson(json);
}
