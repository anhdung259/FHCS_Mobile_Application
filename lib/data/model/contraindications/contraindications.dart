import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contraindications.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Contraindications extends Taggable {
  String id;
  String name;
  String description;
  List<String> allergyIds;
  List<String> diseaseStatusIds;

  Contraindications(
      {this.id,
      this.name,
      this.description,
      this.allergyIds,
      this.diseaseStatusIds});
  Contraindications.instance();
  @override
  String toString() => name;
  Contraindications fromJson(Map<String, dynamic> json) {
    return _$ContraindicationsFromJson(json);
  }

  factory Contraindications.fromJson(Map<String, dynamic> json) =>
      _$ContraindicationsFromJson(json);
  Map<String, dynamic> toJson() => _$ContraindicationsToJson(this);

  @override
  List<Object> get props => [name];
}
