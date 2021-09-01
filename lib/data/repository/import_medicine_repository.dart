import 'package:fhcs_mobile_application/data/model/requests/insert_batch_medicine_request/insert_batch_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class ImportMedicineRepository {
  final ApiProvider apiClient;

  ImportMedicineRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<ResponseServer> searchMedicineInImportBatch(SearchRequest request) {
    return apiClient.searchMedicineInImportBatch(request);
  }

  Future<ResponseServer> insertMedicineInImportBatch(
      InsertMedicineInImportBatchRequest request, String id) {
    return apiClient.insertMedicineInImportBatch(request, id);
  }

  Future<ResponseServer> updateMedicineInImportBatch(
      InsertMedicineInImportBatchRequest request, String id) {
    return apiClient.updateMedicineInImportBatch(request, id);
  }

  Future<ResponseServer> getMedicineInImportBatchDetail(String id) {
    return apiClient.getMedicineInImportBatchDetail(id);
  }

  Future<ResponseServer> deleteMedicineInImportBatch(String id) {
    return apiClient.deleteMedicineInImportBatch(id);
  }

  Future<ResponseServer> getMinMaxPriceImportMedicine() {
    return apiClient.getMinMaxPriceImportMedicine();
  }
}
