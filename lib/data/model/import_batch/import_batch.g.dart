// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportBatch _$ImportBatchFromJson(Map<String, dynamic> json) {
  return ImportBatch(
    id: json['id'] as String,
    createDate: json['createDate'] as String,
    numberOfSpecificMedicine: json['numberOfSpecificMedicine'] as int,
    periodicInventory: json['periodicInventory'] == null
        ? null
        : PeriodicInventory.fromJson(
            json['periodicInventory'] as Map<String, dynamic>),
    totalPrice: (json['totalPrice'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ImportBatchToJson(ImportBatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numberOfSpecificMedicine': instance.numberOfSpecificMedicine,
      'createDate': instance.createDate,
      'totalPrice': instance.totalPrice,
      'periodicInventory': instance.periodicInventory,
    };
