// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_classification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineClassification _$MedicineClassificationFromJson(
    Map<String, dynamic> json) {
  return MedicineClassification(
    id: json['id'] as String,
    description: json['description'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$MedicineClassificationToJson(
        MedicineClassification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
