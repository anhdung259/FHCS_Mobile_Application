// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_result_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineResultSearch _$MedicineResultSearchFromJson(Map<String, dynamic> json) {
  return MedicineResultSearch(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    medicineClassification: json['medicineClassification'] == null
        ? null
        : MedicineClassification.fromJson(
            json['medicineClassification'] as Map<String, dynamic>),
    medicineSubgroup: json['medicineSubgroup'] == null
        ? null
        : MedicineSubgroup.fromJson(
            json['medicineSubgroup'] as Map<String, dynamic>),
    medicineUnit: json['medicineUnit'] == null
        ? null
        : MedicineUnit.fromJson(json['medicineUnit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MedicineResultSearchToJson(
        MedicineResultSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'medicineClassification': instance.medicineClassification,
      'medicineSubgroup': instance.medicineSubgroup,
      'medicineUnit': instance.medicineUnit,
    };
