// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_import_batch_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportBatchDetail _$ImportBatchDetailFromJson(Map<String, dynamic> json) {
  return ImportBatchDetail(
    id: json['id'] as String,
    importMedicines: (json['importMedicines'] as List)
        ?.map((e) => e == null
            ? null
            : ImportBatchMedicine.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createDate: json['createDate'] as String,
    numberOfSpecificMedicine: json['numberOfSpecificMedicine'] as int,
    periodicInventory: json['periodicInventory'] == null
        ? null
        : PeriodicInventory.fromJson(
            json['periodicInventory'] as Map<String, dynamic>),
    periodicInventoryId: json['periodicInventoryId'] as String,
    totalPrice: (json['totalPrice'] as num)?.toDouble(),
    updateDate: json['updateDate'] as String,
  );
}

Map<String, dynamic> _$ImportBatchDetailToJson(ImportBatchDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'importMedicines': instance.importMedicines,
      'periodicInventory': instance.periodicInventory,
      'numberOfSpecificMedicine': instance.numberOfSpecificMedicine,
      'totalPrice': instance.totalPrice,
      'periodicInventoryId': instance.periodicInventoryId,
      'createDate': instance.createDate,
      'updateDate': instance.updateDate,
    };
