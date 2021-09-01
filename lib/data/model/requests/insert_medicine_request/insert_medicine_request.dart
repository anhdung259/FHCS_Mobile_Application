import 'package:json_annotation/json_annotation.dart';
part 'insert_medicine_request.g.dart';

@JsonSerializable()
class InsertMedicineRequest {
  String name;
  String medicineUnitId;
  String description;
  String medicineSubgroupId;
  String medicineClassificationId;
  List<String> diagnosticIds;
  List<String> contraindicationIds;
  InsertMedicineRequest(
      {this.name,
      this.medicineUnitId,
      this.description,
      this.medicineClassificationId,
      this.medicineSubgroupId,
      this.diagnosticIds,
      this.contraindicationIds});
  Map<String, dynamic> toJson() => _$InsertMedicineRequestToJson(this);
}
