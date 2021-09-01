import 'package:fhcs_mobile_application/data/model/requests/notifi_click_request/notifi_click_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class NotificationRepository {
  final ApiProvider apiClient;

  NotificationRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<ResponseServer> searchNotification(SearchRequest request) {
    return apiClient.searchNotification(request);
  }

  Future<ResponseServer> searchNotificationHistoryAction(
      SearchRequest request) {
    return apiClient.searchNotificationHistoryAction(request);
  }

  Future<ResponseServer> clickingNotification(NotifiClickRequest request) {
    return apiClient.clickingNotification(request);
  }
}
