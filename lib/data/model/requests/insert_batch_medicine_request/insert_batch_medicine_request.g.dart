// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_batch_medicine_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertMedicineInImportBatchRequest _$InsertMedicineInImportBatchRequestFromJson(
    Map<String, dynamic> json) {
  return InsertMedicineInImportBatchRequest(
    quantity: json['quantity'] as int,
    price: (json['price'] as num)?.toDouble(),
    insertDate: json['insertDate'] as String,
    expirationDate: json['expirationDate'] as String,
    medicineId: json['medicineId'] as String,
    warningExpirationDate: json['warningExpirationDate'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$InsertMedicineInImportBatchRequestToJson(
        InsertMedicineInImportBatchRequest instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'price': instance.price,
      'description': instance.description,
      'insertDate': instance.insertDate,
      'expirationDate': instance.expirationDate,
      'medicineId': instance.medicineId,
      'warningExpirationDate': instance.warningExpirationDate,
    };
