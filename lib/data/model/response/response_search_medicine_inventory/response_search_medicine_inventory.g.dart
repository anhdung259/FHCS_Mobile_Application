// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_search_medicine_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineInventoryResponseSearch _$MedicineInventoryResponseSearchFromJson(
    Map<String, dynamic> json) {
  return MedicineInventoryResponseSearch(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : MedicineInventoryResultSearch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MedicineInventoryResponseSearchToJson(
        MedicineInventoryResponseSearch instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
