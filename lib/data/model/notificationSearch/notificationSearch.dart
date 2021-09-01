import 'package:fhcs_mobile_application/data/model/data_notification/data_notification.dart';
import 'package:fhcs_mobile_application/data/model/notification/notification.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notificationSearch.g.dart';

@JsonSerializable()
class NotificationSearch {
  String id;
  NotificationServer notification;
  DataNotification data;
  String createAt;
  bool isClicked;
  NotificationSearch(
      {this.id, this.notification, this.data, this.createAt, this.isClicked});
  NotificationSearch.instance();
  NotificationSearch fromJson(Map<String, dynamic> json) {
    return _$NotificationSearchFromJson(json);
  }

  factory NotificationSearch.fromJson(Map<String, dynamic> json) =>
      _$NotificationSearchFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSearchToJson(this);
}
