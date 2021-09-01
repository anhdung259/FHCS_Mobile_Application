// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_batch_medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportBatchMedicine _$ImportBatchMedicineFromJson(Map<String, dynamic> json) {
  return ImportBatchMedicine(
    id: json['id'] as String,
    quantity: json['quantity'] as int,
    price: (json['price'] as num)?.toDouble(),
    description: json['description'] as String,
    importMedicineStatus: json['importMedicineStatus'] == null
        ? null
        : Status.fromJson(json['importMedicineStatus'] as Map<String, dynamic>),
    insertDate: json['insertDate'] as String,
    expirationDate: json['expirationDate'] as String,
    medicineId: json['medicineId'] as String,
    name: json['name'] as String,
    unit: json['unit'] as String,
    importBatchId: json['importBatchId'] as String,
    medicine: json['medicine'] == null
        ? null
        : MedicineResultSearch.fromJson(
            json['medicine'] as Map<String, dynamic>),
    medicineUnit: json['medicineUnit'] == null
        ? null
        : MedicineUnit.fromJson(json['medicineUnit'] as Map<String, dynamic>),
    warningExpirationDate: json['warningExpirationDate'] as String,
    periodicInventory: json['periodicInventory'] == null
        ? null
        : PeriodicInventory.fromJson(
            json['periodicInventory'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ImportBatchMedicineToJson(
        ImportBatchMedicine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'price': instance.price,
      'description': instance.description,
      'insertDate': instance.insertDate,
      'expirationDate': instance.expirationDate,
      'medicineId': instance.medicineId,
      'name': instance.name,
      'unit': instance.unit,
      'importBatchId': instance.importBatchId,
      'warningExpirationDate': instance.warningExpirationDate,
      'importMedicineStatus': instance.importMedicineStatus,
      'periodicInventory': instance.periodicInventory,
      'medicineUnit': instance.medicineUnit,
      'medicine': instance.medicine,
    };
