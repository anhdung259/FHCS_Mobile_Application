// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_medicine_inventory_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineInventoryDetailResponse _$MedicineInventoryDetailResponseFromJson(
    Map<String, dynamic> json) {
  return MedicineInventoryDetailResponse(
    importMedicine: json['importMedicine'] == null
        ? null
        : ImportBatchMedicine.fromJson(
            json['importMedicine'] as Map<String, dynamic>),
    periodicInventory: json['periodicInventory'] == null
        ? null
        : PeriodicInventory.fromJson(
            json['periodicInventory'] as Map<String, dynamic>),
    quantity: json['quantity'] as int,
    medicine: json['medicine'] == null
        ? null
        : Medicine.fromJson(json['medicine'] as Map<String, dynamic>),
  )
    ..medicineSubgroup = json['medicineSubgroup'] == null
        ? null
        : MedicineSubgroup.fromJson(
            json['medicineSubgroup'] as Map<String, dynamic>)
    ..medicineUnit = json['medicineUnit'] == null
        ? null
        : MedicineUnit.fromJson(json['medicineUnit'] as Map<String, dynamic>)
    ..medicineClassification = json['medicineClassification'] == null
        ? null
        : MedicineClassification.fromJson(
            json['medicineClassification'] as Map<String, dynamic>)
    ..priceMin = json['priceMin'] as String
    ..priceMax = json['priceMax'] as String;
}

Map<String, dynamic> _$MedicineInventoryDetailResponseToJson(
        MedicineInventoryDetailResponse instance) =>
    <String, dynamic>{
      'importMedicine': instance.importMedicine,
      'quantity': instance.quantity,
      'periodicInventory': instance.periodicInventory,
      'medicine': instance.medicine,
      'medicineSubgroup': instance.medicineSubgroup,
      'medicineUnit': instance.medicineUnit,
      'medicineClassification': instance.medicineClassification,
      'priceMin': instance.priceMin,
      'priceMax': instance.priceMax,
    };
