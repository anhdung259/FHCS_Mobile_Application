// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_medicine_in_import_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineInImportBatchList _$MedicineInImportBatchListFromJson(
    Map<String, dynamic> json) {
  return MedicineInImportBatchList(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ImportBatchMedicine.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MedicineInImportBatchListToJson(
        MedicineInImportBatchList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
