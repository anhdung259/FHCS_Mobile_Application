// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Allergy _$AllergyFromJson(Map<String, dynamic> json) {
  return Allergy(
    id: json['id'] as String,
    name: json['name'] as String,
  )..allergyId = json['allergyId'] as String;
}

Map<String, dynamic> _$AllergyToJson(Allergy instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'allergyId': instance.allergyId,
    };
