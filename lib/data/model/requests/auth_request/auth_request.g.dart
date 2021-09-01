// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) {
  return AuthRequest(
    accessToken: json['accessToken'] as String,
    provider: json['provider'] as int,
    fromAppLogin: json['fromAppLogin'] as int,
    fcmToken: json['fcmToken'] as String,
    username: json['username'] as String,
    oldPassword: json['oldPassword'] as String,
    password: json['password'] as String,
    newPassword: json['newPassword'] as String,
    confirmNewPassword: json['confirmNewPassword'] as String,
    verifyCode: json['verifyCode'] as String,
  );
}

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'provider': instance.provider,
      'fromAppLogin': instance.fromAppLogin,
      'username': instance.username,
      'password': instance.password,
      'verifyCode': instance.verifyCode,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
      'fcmToken': instance.fcmToken,
    };
