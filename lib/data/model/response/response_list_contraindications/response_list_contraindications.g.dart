// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_contraindications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContraindicationsList _$ContraindicationsListFromJson(
    Map<String, dynamic> json) {
  return ContraindicationsList(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : Contraindications.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContraindicationsListToJson(
        ContraindicationsList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
