import 'package:json_annotation/json_annotation.dart';
part 'notification.g.dart';

@JsonSerializable()
class NotificationServer {
  String title;
  String body;

  NotificationServer({this.title, this.body});
  NotificationServer.instance();
  NotificationServer fromJson(Map<String, dynamic> json) {
    return _$NotificationServerFromJson(json);
  }

  factory NotificationServer.fromJson(Map<String, dynamic> json) =>
      _$NotificationServerFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationServerToJson(this);
}
