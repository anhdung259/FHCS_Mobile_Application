// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataNotification _$DataNotificationFromJson(Map<String, dynamic> json) {
  return DataNotification(
    action: json['action'] as String,
    entity: json['entity'] as String,
    data: json['data'] as String,
    notificationId: json['notificationId'] as String,
  );
}

Map<String, dynamic> _$DataNotificationToJson(DataNotification instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'action': instance.action,
      'entity': instance.entity,
      'data': instance.data,
    };
