import 'package:fhcs_mobile_application/data/model/notificationSearch/notificationSearch.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_list_notification.g.dart';

@JsonSerializable()
class NotificationListSearch {
  List<NotificationSearch> data;
  Info info;
  NotificationListSearch(this.data, this.info);
  NotificationListSearch.instance();
  NotificationListSearch fromJson(Map<String, dynamic> json) {
    return _$NotificationListSearchFromJson(json);
  }

  factory NotificationListSearch.fromJson(Map<String, dynamic> json) =>
      _$NotificationListSearchFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationListSearchToJson(this);
}
