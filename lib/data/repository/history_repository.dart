import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class HistoryRepository {
  final ApiProvider apiClient;

  HistoryRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseServer> getPatientDetail(String id) {
    return apiClient.getPatientDetail(id);
  }

  Future<ResponseServer> fetchPatient(SearchRequest request) {
    return apiClient.fetchPatient(request);
  }
  Future<ResponseServer> searchTreatmentInfo(SearchRequest request) {
    return apiClient.searchTreatmentInfo(request);
  }
}
