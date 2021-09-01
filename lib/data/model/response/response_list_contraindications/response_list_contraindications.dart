import 'package:fhcs_mobile_application/data/model/contraindications/contraindications.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_list_contraindications.g.dart';

@JsonSerializable()
class ContraindicationsList {
  List<Contraindications> data;
  ContraindicationsList(this.data);
  ContraindicationsList.instance();
  ContraindicationsList fromJson(Map<String, dynamic> json) {
    return _$ContraindicationsListFromJson(json);
  }

  factory ContraindicationsList.fromJson(Map<String, dynamic> json) =>
      _$ContraindicationsListFromJson(json);
  Map<String, dynamic> toJson() => _$ContraindicationsListToJson(this);
}
