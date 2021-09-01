// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSearch _$NotificationSearchFromJson(Map<String, dynamic> json) {
  return NotificationSearch(
    id: json['id'] as String,
    notification: json['notification'] == null
        ? null
        : NotificationServer.fromJson(
            json['notification'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : DataNotification.fromJson(json['data'] as Map<String, dynamic>),
    createAt: json['createAt'] as String,
    isClicked: json['isClicked'] as bool,
  );
}

Map<String, dynamic> _$NotificationSearchToJson(NotificationSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notification': instance.notification,
      'data': instance.data,
      'createAt': instance.createAt,
      'isClicked': instance.isClicked,
    };
