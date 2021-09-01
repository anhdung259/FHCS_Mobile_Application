import 'package:fhcs_mobile_application/data/model/requests/insert_import_batch/insert_import_batch_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class ImportBatchRepository {
  final ApiProvider apiClient;

  ImportBatchRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseServer> searchImportBatch(SearchRequest request) {
    return apiClient.searchImportBatch(request);
  }

  Future<ResponseServer> insertImportBatch(InsertImportBatchRequest request) {
    return apiClient.insertImportBatch(request);
  }

  Future<ResponseServer> updateImportBatch(
      InsertImportBatchRequest request, String importId) {
    return apiClient.updateImportBatch(request, importId);
  }

  Future<ResponseServer> getImportBatchDetail(String id) {
    return apiClient.getImportBatchDetail(id);
  }

  Future<ResponseServer> deleteImportBatch(String importBatchId) {
    return apiClient.deleteImportBatch(importBatchId);
  }

  Future<ResponseServer> getMinMaxPriceImportBatch() {
    return apiClient.getMinMaxPriceImportBatch();
  }

  Future<ResponseServer> searchMedicine(SearchRequest request) {
    return apiClient.searchMedicine(request);
  }
}
