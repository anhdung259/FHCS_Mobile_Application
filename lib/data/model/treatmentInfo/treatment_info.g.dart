// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentInfo _$TreatmentInfoFromJson(Map<String, dynamic> json) {
  return TreatmentInfo(
    id: json['id'] as String,
    nameMedicine: json['nameMedicine'] as String,
    medicineId: json['medicineId'] as String,
    quantity: json['quantity'] as int,
    indicationToDrink: json['indicationToDrink'] as String,
    unitMedicine: json['unitMedicine'] as String,
    inventoryId: json['inventoryId'] as String,
    quantityInventory: json['quantityInventory'] as String,
    treatmentInformationDetails: (json['treatmentInformationDetails'] as List)
        ?.map((e) => e == null
            ? null
            : TreatmentInfoDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TreatmentInfoToJson(TreatmentInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicineId': instance.medicineId,
      'nameMedicine': instance.nameMedicine,
      'unitMedicine': instance.unitMedicine,
      'quantity': instance.quantity,
      'indicationToDrink': instance.indicationToDrink,
      'inventoryId': instance.inventoryId,
      'quantityInventory': instance.quantityInventory,
      'treatmentInformationDetails': instance.treatmentInformationDetails,
    };
