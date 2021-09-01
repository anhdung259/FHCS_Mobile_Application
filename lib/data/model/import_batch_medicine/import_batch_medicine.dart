import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:fhcs_mobile_application/data/model/medicine_result_search/medicine_result_search.dart';
import 'package:fhcs_mobile_application/data/model/periodicInventory/periodic_inventory.dart';
import 'package:fhcs_mobile_application/data/model/status/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'import_batch_medicine.g.dart';

@JsonSerializable()
class ImportBatchMedicine {
  String id;
  int quantity;
  double price;
  String description;
  String insertDate;
  String expirationDate;
  String medicineId;
  String name;
  String unit;
  String importBatchId;
  String warningExpirationDate;
  Status importMedicineStatus;
  PeriodicInventory periodicInventory;
  MedicineUnit medicineUnit;
  MedicineResultSearch medicine;

  ImportBatchMedicine(
      {this.id,
      this.quantity,
      this.price,
      this.description,
      this.importMedicineStatus,
      this.insertDate,
      this.expirationDate,
      this.medicineId,
      this.name,
      this.unit,
      this.importBatchId,
      this.medicine,
      this.medicineUnit,
      this.warningExpirationDate,
      this.periodicInventory});
  ImportBatchMedicine.instance();
  ImportBatchMedicine fromJson(Map<String, dynamic> json) {
    return _$ImportBatchMedicineFromJson(json);
  }

  factory ImportBatchMedicine.fromJson(Map<String, dynamic> json) =>
      _$ImportBatchMedicineFromJson(json);
  Map<String, dynamic> toJson() => _$ImportBatchMedicineToJson(this);
}
