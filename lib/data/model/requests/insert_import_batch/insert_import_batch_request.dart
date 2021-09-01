import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:json_annotation/json_annotation.dart';
part 'insert_import_batch_request.g.dart';

@JsonSerializable()
class InsertImportBatchRequest {
  double totalPrice;
  String periodicInventoryMonth;
  String periodicInventoryYear;
  List<ImportBatchMedicine> importMedicines;
  InsertImportBatchRequest(
      {this.importMedicines,
      this.periodicInventoryMonth,
      this.periodicInventoryYear,
      this.totalPrice});
  Map<String, dynamic> toJson() => _$InsertImportBatchRequestToJson(this);
}
