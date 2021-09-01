import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:fhcs_mobile_application/data/model/periodicInventory/periodic_inventory.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_import_batch_detail.g.dart';

@JsonSerializable()
class ImportBatchDetail {
  String id;
  List<ImportBatchMedicine> importMedicines;
  PeriodicInventory periodicInventory;
  int numberOfSpecificMedicine;
  double totalPrice;
  String periodicInventoryId;
  String createDate;
  String updateDate;

  ImportBatchDetail({
    this.id,
    this.importMedicines,
    this.createDate,
    this.numberOfSpecificMedicine,
    this.periodicInventory,
    this.periodicInventoryId,
    this.totalPrice,
    this.updateDate,
  });
  ImportBatchDetail.instance();
  ImportBatchDetail fromJson(Map<String, dynamic> json) {
    return _$ImportBatchDetailFromJson(json);
  }

  factory ImportBatchDetail.fromJson(Map<String, dynamic> json) =>
      _$ImportBatchDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ImportBatchDetailToJson(this);
}
