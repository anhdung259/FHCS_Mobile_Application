import 'package:fhcs_mobile_application/data/model/treatment_information_details/treatment_information_details.dart';

import 'package:json_annotation/json_annotation.dart';
part 'treatment_info.g.dart';

@JsonSerializable()
class TreatmentInfo {
  String id;
  String medicineId;
  String nameMedicine;
  String unitMedicine;
  int quantity;
  String indicationToDrink;
  String inventoryId;
  String quantityInventory;
  List<TreatmentInfoDetail> treatmentInformationDetails;

  TreatmentInfo(
      {this.id,
      this.nameMedicine,
      this.medicineId,
      this.quantity,
      this.indicationToDrink,
      this.unitMedicine,
      this.inventoryId,
      this.quantityInventory,
      this.treatmentInformationDetails});
  TreatmentInfo.instance();
  TreatmentInfo fromJson(Map<String, dynamic> json) {
    return _$TreatmentInfoFromJson(json);
  }

  factory TreatmentInfo.fromJson(Map<String, dynamic> json) =>
      _$TreatmentInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentInfoToJson(this);
}
