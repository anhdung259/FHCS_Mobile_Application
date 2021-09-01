import 'package:fhcs_mobile_application/data/model/requests/eliminate_medicine_request/eliminate_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class MedicineInventoryRepository {
  final ApiProvider apiClient;

  MedicineInventoryRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<ResponseServer> searchMedicineInventoryDetail(SearchRequest request) {
    return apiClient.searchMedicineInventoryDetail(request);
  }

  Future<ResponseServer> getMedicineInventoryDetail(String id) {
    return apiClient.getMedicineInventoryDetail(id);
  }

  Future<ResponseServer> eliminateMedicine(EliminateMedicineRequest request) {
    return apiClient.eliminateMedicine(request);
  }

  Future<ResponseServer> getMinMaxPriceImportMedicine() {
    return apiClient.getMinMaxPriceImportMedicine();
  }
}
