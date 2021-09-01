// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_export_import_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineExportImportInventory _$MedicineExportImportInventoryFromJson(
    Map<String, dynamic> json) {
  return MedicineExportImportInventory(
    id: json['id'] as String,
    quantity: json['quantity'] as int,
    importMedicine: json['importMedicine'] == null
        ? null
        : ImportBatchMedicine.fromJson(
            json['importMedicine'] as Map<String, dynamic>),
    exportMedicines: (json['exportMedicines'] as List)
        ?.map((e) => e == null
            ? null
            : ImportBatchMedicine.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    beginInventories: (json['beginInventories'] as List)
        ?.map((e) => e == null
            ? null
            : BeginInventory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MedicineExportImportInventoryToJson(
        MedicineExportImportInventory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'importMedicine': instance.importMedicine,
      'exportMedicines': instance.exportMedicines,
      'beginInventories': instance.beginInventories,
    };
