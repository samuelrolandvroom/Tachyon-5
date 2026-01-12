// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SocialAuthResponseImpl _$$SocialAuthResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SocialAuthResponseImpl(
      status: json['status'] as String,
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      socialData: json['socialData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SocialAuthResponseImplToJson(
        _$SocialAuthResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'token': instance.token,
      'user': instance.user,
      'socialData': instance.socialData,
    };
