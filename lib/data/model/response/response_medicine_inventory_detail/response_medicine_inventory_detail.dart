import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:fhcs_mobile_application/data/model/medicine/medicine.dart';
import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:fhcs_mobile_application/data/model/periodicInventory/periodic_inventory.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_medicine_inventory_detail.g.dart';

@JsonSerializable()
class MedicineInventoryDetailResponse {
  ImportBatchMedicine importMedicine;
  int quantity;
  PeriodicInventory periodicInventory;
  Medicine medicine;
  MedicineSubgroup medicineSubgroup;
  MedicineUnit medicineUnit;
  MedicineClassification medicineClassification;
  String priceMin;
  String priceMax;

  MedicineInventoryDetailResponse(
      {this.importMedicine,
      this.periodicInventory,
      this.quantity,
      this.medicine});
  MedicineInventoryDetailResponse.instance();
  MedicineInventoryDetailResponse fromJson(Map<String, dynamic> json) {
    return _$MedicineInventoryDetailResponseFromJson(json);
  }

  factory MedicineInventoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicineInventoryDetailResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MedicineInventoryDetailResponseToJson(this);
}
