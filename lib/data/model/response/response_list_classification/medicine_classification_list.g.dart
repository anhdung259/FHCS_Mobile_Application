// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_classification_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineClassificationList _$MedicineClassificationListFromJson(
    Map<String, dynamic> json) {
  return MedicineClassificationList(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : MedicineClassification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MedicineClassificationListToJson(
        MedicineClassificationList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
