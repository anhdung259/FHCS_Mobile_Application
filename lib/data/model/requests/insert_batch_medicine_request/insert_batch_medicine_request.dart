import 'package:json_annotation/json_annotation.dart';
part 'insert_batch_medicine_request.g.dart';

@JsonSerializable()
class InsertMedicineInImportBatchRequest {
  int quantity;
  double price;
  String description;
  String insertDate;
  String expirationDate;
  String medicineId;
  String warningExpirationDate;

  InsertMedicineInImportBatchRequest(
      {this.quantity,
      this.price,
      this.insertDate,
      this.expirationDate,
      this.medicineId,
      this.warningExpirationDate,
      this.description});
  Map<String, dynamic> toJson() =>
      _$InsertMedicineInImportBatchRequestToJson(this);
}
