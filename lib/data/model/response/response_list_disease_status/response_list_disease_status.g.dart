// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_disease_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiseaseStatusList _$DiseaseStatusListFromJson(Map<String, dynamic> json) {
  return DiseaseStatusList(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Diagnostic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DiseaseStatusListToJson(DiseaseStatusList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
