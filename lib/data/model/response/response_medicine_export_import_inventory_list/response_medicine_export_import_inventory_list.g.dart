// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_medicine_export_import_inventory_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineExportImportInventoryList _$MedicineExportImportInventoryListFromJson(
    Map<String, dynamic> json) {
  return MedicineExportImportInventoryList(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : MedicineExportImportInventory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MedicineExportImportInventoryListToJson(
        MedicineExportImportInventoryList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
