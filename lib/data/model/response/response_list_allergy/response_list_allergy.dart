import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_list_allergy.g.dart';

@JsonSerializable()
class AllergyList {
  List<Allergy> data;
  AllergyList(this.data);
  AllergyList.instance();
  AllergyList fromJson(Map<String, dynamic> json) {
    return _$AllergyListFromJson(json);
  }

  factory AllergyList.fromJson(Map<String, dynamic> json) =>
      _$AllergyListFromJson(json);
  Map<String, dynamic> toJson() => _$AllergyListToJson(this);
}
