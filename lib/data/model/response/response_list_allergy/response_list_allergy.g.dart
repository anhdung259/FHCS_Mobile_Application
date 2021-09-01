// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_allergy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllergyList _$AllergyListFromJson(Map<String, dynamic> json) {
  return AllergyList(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Allergy.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllergyListToJson(AllergyList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
