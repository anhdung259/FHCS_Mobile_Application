import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medicine_classification_list.g.dart';

@JsonSerializable()
class MedicineClassificationList {
  List<MedicineClassification> data;
  MedicineClassificationList(this.data);
  MedicineClassificationList.instance();
  MedicineClassificationList fromJson(Map<String, dynamic> json) {
    return _$MedicineClassificationListFromJson(json);
  }

  factory MedicineClassificationList.fromJson(Map<String, dynamic> json) =>
      _$MedicineClassificationListFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineClassificationListToJson(this);
}
