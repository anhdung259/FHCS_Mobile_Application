// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_search_medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineResponseSearch _$MedicineResponseSearchFromJson(
    Map<String, dynamic> json) {
  return MedicineResponseSearch(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : MedicineResultSearch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MedicineResponseSearchToJson(
        MedicineResponseSearch instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
