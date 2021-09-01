// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_subgroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineSubgroupResponse _$MedicineSubgroupResponseFromJson(
    Map<String, dynamic> json) {
  return MedicineSubgroupResponse(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : MedicineSubgroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MedicineSubgroupResponseToJson(
        MedicineSubgroupResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
