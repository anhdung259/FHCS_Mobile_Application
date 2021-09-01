import 'package:json_annotation/json_annotation.dart';
part 'eliminate_medicine_request.g.dart';

@JsonSerializable()
class EliminateMedicineRequest {
  String medicineInInventoryDetailId;
  int quantity;
  String reason;

  EliminateMedicineRequest(
      {this.medicineInInventoryDetailId, this.quantity, this.reason});
  Map<String, dynamic> toJson() => _$EliminateMedicineRequestToJson(this);
}
