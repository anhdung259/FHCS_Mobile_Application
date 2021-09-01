// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineUnit _$MedicineUnitFromJson(Map<String, dynamic> json) {
  return MedicineUnit(
    id: json['id'] as String,
    acronymUnit: json['acronymUnit'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$MedicineUnitToJson(MedicineUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'acronymUnit': instance.acronymUnit,
    };
