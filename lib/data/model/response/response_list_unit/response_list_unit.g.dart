// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineUnitResponse _$MedicineUnitResponseFromJson(Map<String, dynamic> json) {
  return MedicineUnitResponse(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : MedicineUnit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MedicineUnitResponseToJson(
        MedicineUnitResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
