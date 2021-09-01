import 'package:fhcs_mobile_application/data/model/begin_inventories/begin_inventory.dart';
import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine_export_import_inventory.g.dart';

@JsonSerializable()
class MedicineExportImportInventory {
  String id;
  int quantity;
  ImportBatchMedicine importMedicine;
  List<ImportBatchMedicine> exportMedicines;
  List<BeginInventory> beginInventories;
  MedicineExportImportInventory({
    this.id,
    this.quantity = 0,
    this.importMedicine,
    this.exportMedicines,
    this.beginInventories,
  });
  MedicineExportImportInventory.instance();
  MedicineExportImportInventory fromJson(Map<String, dynamic> json) {
    return _$MedicineExportImportInventoryFromJson(json);
  }

  factory MedicineExportImportInventory.fromJson(Map<String, dynamic> json) =>
      _$MedicineExportImportInventoryFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineExportImportInventoryToJson(this);
}
