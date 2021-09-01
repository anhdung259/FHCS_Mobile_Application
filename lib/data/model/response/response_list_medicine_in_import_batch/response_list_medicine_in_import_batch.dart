import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_list_medicine_in_import_batch.g.dart';

@JsonSerializable()
class MedicineInImportBatchList {
  List<ImportBatchMedicine> data;
  Info info;
  MedicineInImportBatchList(this.data, this.info);
  MedicineInImportBatchList.instance();
  MedicineInImportBatchList fromJson(Map<String, dynamic> json) {
    return _$MedicineInImportBatchListFromJson(json);
  }

  factory MedicineInImportBatchList.fromJson(Map<String, dynamic> json) =>
      _$MedicineInImportBatchListFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineInImportBatchListToJson(this);
}
