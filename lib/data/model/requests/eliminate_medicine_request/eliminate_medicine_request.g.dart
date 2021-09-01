// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eliminate_medicine_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EliminateMedicineRequest _$EliminateMedicineRequestFromJson(
    Map<String, dynamic> json) {
  return EliminateMedicineRequest(
    medicineInInventoryDetailId: json['medicineInInventoryDetailId'] as String,
    quantity: json['quantity'] as int,
    reason: json['reason'] as String,
  );
}

Map<String, dynamic> _$EliminateMedicineRequestToJson(
        EliminateMedicineRequest instance) =>
    <String, dynamic>{
      'medicineInInventoryDetailId': instance.medicineInInventoryDetailId,
      'quantity': instance.quantity,
      'reason': instance.reason,
    };
