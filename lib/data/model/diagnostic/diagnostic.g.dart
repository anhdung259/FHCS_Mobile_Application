// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnostic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnostic _$DiseaseStatusFromJson(Map<String, dynamic> json) {
  return Diagnostic(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icdCode: json['icdCode'] as String);
}

Map<String, dynamic> _$DiseaseStatusToJson(Diagnostic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icdCode': instance.icdCode
    };
