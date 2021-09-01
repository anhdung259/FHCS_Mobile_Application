// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationListSearch _$NotificationListSearchFromJson(
    Map<String, dynamic> json) {
  return NotificationListSearch(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : NotificationSearch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NotificationListSearchToJson(
        NotificationListSearch instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
