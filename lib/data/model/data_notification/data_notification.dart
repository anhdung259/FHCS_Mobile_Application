import 'package:json_annotation/json_annotation.dart';
part 'data_notification.g.dart';

@JsonSerializable()
class DataNotification {
  String notificationId;
  String action;
  String entity;
  String data;
  DataNotification({this.action, this.entity, this.data, this.notificationId});
  DataNotification.instance();
  DataNotification fromJson(Map<String, dynamic> json) {
    return _$DataNotificationFromJson(json);
  }

  factory DataNotification.fromJson(Map<String, dynamic> json) =>
      _$DataNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$DataNotificationToJson(this);
}
