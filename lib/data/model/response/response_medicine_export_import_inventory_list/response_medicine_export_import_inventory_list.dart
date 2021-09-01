import 'package:fhcs_mobile_application/data/model/medicine_export_import_inventory/medicine_export_import_inventory.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';

import 'package:json_annotation/json_annotation.dart';

part 'response_medicine_export_import_inventory_list.g.dart';

@JsonSerializable()
class MedicineExportImportInventoryList {
  List<MedicineExportImportInventory> data;
  Info info;
  MedicineExportImportInventoryList(this.data, this.info);
  MedicineExportImportInventoryList.instance();
  MedicineExportImportInventoryList fromJson(Map<String, dynamic> json) {
    return _$MedicineExportImportInventoryListFromJson(json);
  }

  factory MedicineExportImportInventoryList.fromJson(
          Map<String, dynamic> json) =>
      _$MedicineExportImportInventoryListFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MedicineExportImportInventoryListToJson(this);
}
