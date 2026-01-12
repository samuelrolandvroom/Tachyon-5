// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_auth_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SocialAuthResponse _$SocialAuthResponseFromJson(Map<String, dynamic> json) {
  return _SocialAuthResponse.fromJson(json);
}

/// @nodoc
mixin _$SocialAuthResponse {
  String get status =>
      throw _privateConstructorUsedError; // 'complete' or 'incomplete'
  String? get token => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  Map<String, dynamic>? get socialData => throw _privateConstructorUsedError;

  /// Serializes this SocialAuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SocialAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SocialAuthResponseCopyWith<SocialAuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialAuthResponseCopyWith<$Res> {
  factory $SocialAuthResponseCopyWith(
          SocialAuthResponse value, $Res Function(SocialAuthResponse) then) =
      _$SocialAuthResponseCopyWithImpl<$Res, SocialAuthResponse>;
  @useResult
  $Res call(
      {String status,
      String? token,
      User? user,
      Map<String, dynamic>? socialData});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$SocialAuthResponseCopyWithImpl<$Res, $Val extends SocialAuthResponse>
    implements $SocialAuthResponseCopyWith<$Res> {
  _$SocialAuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? token = freezed,
    Object? user = freezed,
    Object? socialData = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      socialData: freezed == socialData
          ? _value.socialData
          : socialData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of SocialAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SocialAuthResponseImplCopyWith<$Res>
    implements $SocialAuthResponseCopyWith<$Res> {
  factory _$$SocialAuthResponseImplCopyWith(_$SocialAuthResponseImpl value,
          $Res Function(_$SocialAuthResponseImpl) then) =
      __$$SocialAuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String? token,
      User? user,
      Map<String, dynamic>? socialData});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$SocialAuthResponseImplCopyWithImpl<$Res>
    extends _$SocialAuthResponseCopyWithImpl<$Res, _$SocialAuthResponseImpl>
    implements _$$SocialAuthResponseImplCopyWith<$Res> {
  __$$SocialAuthResponseImplCopyWithImpl(_$SocialAuthResponseImpl _value,
      $Res Function(_$SocialAuthResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SocialAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? token = freezed,
    Object? user = freezed,
    Object? socialData = freezed,
  }) {
    return _then(_$SocialAuthResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      socialData: freezed == socialData
          ? _value._socialData
          : socialData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialAuthResponseImpl implements _SocialAuthResponse {
  const _$SocialAuthResponseImpl(
      {required this.status,
      this.token,
      this.user,
      final Map<String, dynamic>? socialData})
      : _socialData = socialData;

  factory _$SocialAuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialAuthResponseImplFromJson(json);

  @override
  final String status;
// 'complete' or 'incomplete'
  @override
  final String? token;
  @override
  final User? user;
  final Map<String, dynamic>? _socialData;
  @override
  Map<String, dynamic>? get socialData {
    final value = _socialData;
    if (value == null) return null;
    if (_socialData is EqualUnmodifiableMapView) return _socialData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SocialAuthResponse(status: $status, token: $token, user: $user, socialData: $socialData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuthResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality()
                .equals(other._socialData, _socialData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, token, user,
      const DeepCollectionEquality().hash(_socialData));

  /// Create a copy of SocialAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialAuthResponseImplCopyWith<_$SocialAuthResponseImpl> get copyWith =>
      __$$SocialAuthResponseImplCopyWithImpl<_$SocialAuthResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialAuthResponseImplToJson(
      this,
    );
  }
}

abstract class _SocialAuthResponse implements SocialAuthResponse {
  const factory _SocialAuthResponse(
      {required final String status,
      final String? token,
      final User? user,
      final Map<String, dynamic>? socialData}) = _$SocialAuthResponseImpl;

  factory _SocialAuthResponse.fromJson(Map<String, dynamic> json) =
      _$SocialAuthResponseImpl.fromJson;

  @override
  String get status; // 'complete' or 'incomplete'
  @override
  String? get token;
  @override
  User? get user;
  @override
  Map<String, dynamic>? get socialData;

  /// Create a copy of SocialAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialAuthResponseImplCopyWith<_$SocialAuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
