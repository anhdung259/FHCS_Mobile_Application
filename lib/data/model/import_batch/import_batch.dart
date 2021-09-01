import 'package:fhcs_mobile_application/data/model/periodicInventory/periodic_inventory.dart';
import 'package:json_annotation/json_annotation.dart';
part 'import_batch.g.dart';

@JsonSerializable()
class ImportBatch {
  String id;
  int numberOfSpecificMedicine;
  String createDate;
  double totalPrice;
  PeriodicInventory periodicInventory;
  ImportBatch(
      {this.id,
      this.createDate,
      this.numberOfSpecificMedicine,
      this.periodicInventory,
      this.totalPrice});
  ImportBatch.instance();
  ImportBatch fromJson(Map<String, dynamic> json) {
    return _$ImportBatchFromJson(json);
  }

  factory ImportBatch.fromJson(Map<String, dynamic> json) =>
      _$ImportBatchFromJson(json);
  Map<String, dynamic> toJson() => _$ImportBatchToJson(this);
}
