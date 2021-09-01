import 'package:fhcs_mobile_application/data/model/medicine_inventory_result_search/medicine_inventory_result_search.dart';
import 'package:json_annotation/json_annotation.dart';
part 'treatment_information_details.g.dart';

@JsonSerializable()
class TreatmentInfoDetail {
  String medicineInInventoryDetailId;
  int quantity;
  String medicineId;
  String medicineName;
  String unitName;
  bool groupByCheck;
  List<GroupByChoiceMedicine> groupByChoiceMedicine;
  TreatmentInfoDetail(
      {this.medicineInInventoryDetailId,
      this.quantity,
      this.medicineId,
      this.medicineName,
      this.unitName,
      this.groupByCheck,
      this.groupByChoiceMedicine});
  TreatmentInfoDetail.instance();
  TreatmentInfoDetail fromJson(Map<String, dynamic> json) {
    return _$TreatmentInfoDetailFromJson(json);
  }

  factory TreatmentInfoDetail.fromJson(Map<String, dynamic> json) =>
      _$TreatmentInfoDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentInfoDetailToJson(this);
}
