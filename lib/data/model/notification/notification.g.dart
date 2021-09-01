// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationServer _$NotificationServerFromJson(Map<String, dynamic> json) {
  return NotificationServer(
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$NotificationServerToJson(NotificationServer instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
