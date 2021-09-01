// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_information_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentInfoDetail _$TreatmentInfoDetailFromJson(Map<String, dynamic> json) {
  return TreatmentInfoDetail(
    medicineInInventoryDetailId: json['medicineInInventoryDetailId'] as String,
    quantity: json['quantity'] as int,
    medicineId: json['medicineId'] as String,
    medicineName: json['medicineName'] as String,
    unitName: json['unitName'] as String,
  );
}

Map<String, dynamic> _$TreatmentInfoDetailToJson(
        TreatmentInfoDetail instance) =>
    <String, dynamic>{
      'medicineInInventoryDetailId': instance.medicineInInventoryDetailId,
      'quantity': instance.quantity,
      'medicineId': instance.medicineId,
      'medicineName': instance.medicineName,
      'unitName': instance.unitName,
    };
