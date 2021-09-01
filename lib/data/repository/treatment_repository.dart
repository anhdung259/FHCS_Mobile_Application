import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_treament_info_request/insert_treament_info_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class TreatmentInfoRepository {
  final ApiProvider apiClient;

  TreatmentInfoRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<ResponseServer> searchTreatmentInfo(SearchRequest request) {
    return apiClient.searchTreatmentInfo(request);
  }

  Future<ResponseServer> getTreatmentInfoDetail(String id) {
    return apiClient.getTreatmentInfoDetail(id);
  }

  Future<ResponseServer> confirmTreatmentInfo(
      InsertTreatmentInfoRequest request, String treatmentId) {
    return apiClient.confirmTreatmentInfo(request, treatmentId);
  }

  Future<ResponseServer> deleteTreatmentInfo(String treatmentId) {
    return apiClient.deleteTreatmentInfo(treatmentId);
  }

  Future<ResponseServer> insertTreatmentInfo(
      InsertTreatmentInfoRequest insertTreatmentInfoRequest) {
    return apiClient.insertTreatmentInfo(insertTreatmentInfoRequest);
  }

  Future<ResponseServer> checkQuanityAvaiable(String id) {
    return apiClient.checkQuanityAvaiable(id);
  }

  Future<ResponseServer> updateTreatmentInfo(
      InsertTreatmentInfoRequest insertTreatmentInfoRequest,
      String treatmentId) {
    return apiClient.updateTreatmentInfo(
        insertTreatmentInfoRequest, treatmentId);
  }

  Future<ResponseServer> fetchDepartment(SearchRequest request) {
    return apiClient.fetchDepartment(request);
  }

  Future<ResponseServer> insertDepartment(Department request) {
    return apiClient.insertDepartment(request);
  }

  Future<ResponseServer> getPatientByInternalCode(String internalCode) {
    return apiClient.getPatientByInternalCode(internalCode);
  }

  Future<ResponseServer> searchMedicineInventories(SearchRequest request) {
    return apiClient.searchMedicineInventories(request);
  }

  Future<ResponseServer> searchMedicineInventoryDetail(SearchRequest request) {
    return apiClient.searchMedicineInventoryDetail(request);
  }
}
