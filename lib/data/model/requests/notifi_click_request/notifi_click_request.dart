import 'package:json_annotation/json_annotation.dart';

part 'notifi_click_request.g.dart';

@JsonSerializable()
class NotifiClickRequest {
  String notificationId;
  NotifiClickRequest({this.notificationId});

  Map<String, dynamic> toJson() => _$NotifiClickRequestToJson(this);
}
