import 'package:fhcs_mobile_application/data/model/import_batch/import_batch.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_search_import_batch.g.dart';

@JsonSerializable()
class ImportBatchResponseSearch {
  List<ImportBatch> data;
  Info info;
  ImportBatchResponseSearch(this.data, this.info);
  ImportBatchResponseSearch.instance();
  ImportBatchResponseSearch fromJson(Map<String, dynamic> json) {
    return _$ImportBatchResponseSearchFromJson(json);
  }

  factory ImportBatchResponseSearch.fromJson(Map<String, dynamic> json) =>
      _$ImportBatchResponseSearchFromJson(json);
  Map<String, dynamic> toJson() => _$ImportBatchResponseSearchToJson(this);
}
