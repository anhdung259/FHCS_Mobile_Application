// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contraindications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contraindications _$ContraindicationsFromJson(Map<String, dynamic> json) {
  return Contraindications(
    id: json['id'] as String,
    name: json['name'] as String,
    allergyIds: (json['allergyIds'] as List)?.map((e) => e as String)?.toList(),
    diseaseStatusIds:
        (json['diseaseStatusIds'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ContraindicationsToJson(Contraindications instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'allergyIds': instance.allergyIds,
      'diseaseStatusIds': instance.diseaseStatusIds,
      'description': instance.description
    };
