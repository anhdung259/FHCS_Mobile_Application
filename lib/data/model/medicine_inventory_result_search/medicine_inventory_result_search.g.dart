// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_inventory_result_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineInventoryResultSearch _$MedicineInventoryResultSearchFromJson(
    Map<String, dynamic> json) {
  return MedicineInventoryResultSearch(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as double,
    quantity: json['quantity'] as int,
    insertDate: json['insertDate'] as String,
    month: json['month'] as int,
    year: json['year'] as int,
    unitName: json['unitName'] as String,
    expirationDate: json['expirationDate'] as String,
    medicineId: json['medicineId'] as String,
    medicine: json['medicine'] == null
        ? null
        : Medicine.fromJson(json['medicine'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MedicineInventoryResultSearchToJson(
        MedicineInventoryResultSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'insertDate': instance.insertDate,
      'expirationDate': instance.expirationDate,
      'unitName': instance.unitName,
      'month': instance.month,
      'year': instance.year,
      'medicineId': instance.medicineId,
      'medicine': instance.medicine,
    };
