import 'package:fhcs_mobile_application/data/model/contraindications/contraindications.dart';
import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_medicine_request/insert_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class MedicineRepository {
  final ApiProvider apiClient;

  MedicineRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseServer> searchMedicine(SearchRequest request) {
    return apiClient.searchMedicine(request);
  }

  Future<ResponseServer> searchMedicineExportImportInventory(
      SearchRequest request) {
    return apiClient.searchMedicineExportImportInventory(request);
  }

  Future<ResponseServer> getMedicineDetail(String medicineId) {
    return apiClient.getMedicineDetail(medicineId);
  }

  Future<ResponseServer> updateMedicine(
      InsertMedicineRequest request, String medicineId) {
    return apiClient.updateMedicine(request, medicineId);
  }

  Future<ResponseServer> insertMedicine(InsertMedicineRequest request) {
    return apiClient.insertMedicine(request);
  }

  Future<ResponseServer> deleteMedicine(String medicineId) {
    return apiClient.deleteMedicine(medicineId);
  }

  Future<ResponseServer> getSubGroupMedicineDetail(String id) {
    return apiClient.getSubGroupMedicineDetail(id);
  }

  Future<ResponseServer> getUnitMedicinetDetail(String id) {
    return apiClient.getUnitMedicinetDetail(id);
  }

  Future<ResponseServer> getClassifictionMedicineDetail(String id) {
    return apiClient.getClassifictionMedicineDetail(id);
  }

  Future<ResponseServer> insertClassificationMedicine(
      MedicineClassification request) {
    return apiClient.insertClassificationMedicine(request);
  }

  Future<ResponseServer> insertSubGroupMedicine(MedicineSubgroup request) {
    return apiClient.insertSubGroupMedicine(request);
  }

  Future<ResponseServer> insertUnitMedicine(MedicineUnit request) {
    return apiClient.insertUnitMedicine(request);
  }

  Future<ResponseServer> fecthMedicineClassifications(SearchRequest request) {
    return apiClient.fecthMedicineClassifications(request);
  }

  Future<ResponseServer> fecthMedicineUnit(SearchRequest request) {
    return apiClient.fecthMedicineUnit(request);
  }

  Future<ResponseServer> fecthMedicineSubgroup(SearchRequest request) {
    return apiClient.fecthMedicineSubgroup(request);
  }

  Future<ResponseServer> insertContraindication(Contraindications request) {
    return apiClient.insertContraindication(request);
  }

  Future<ResponseServer> fetchContraindications(SearchRequest request) {
    return apiClient.fetchContraindications(request);
  }

  // getId(id) {
  //   return apiClient.getId(id);
  // }

}
