import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allergy.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Allergy extends Taggable {
  String id;
  String name;
  String allergyId;
  Allergy({
    this.id,
    this.name,
  });
  Allergy.instance();
  @override
  String toString() => name;
  Allergy fromJson(Map<String, dynamic> json) {
    return _$AllergyFromJson(json);
  }

  factory Allergy.fromJson(Map<String, dynamic> json) =>
      _$AllergyFromJson(json);
  Map<String, dynamic> toJson() => _$AllergyToJson(this);

  @override
  List<Object> get props => [name];
}
