import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diagnostic.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Diagnostic extends Taggable {
  String id;
  String name;
  String description;
  String icdCode;

  Diagnostic({this.id, this.name, this.description, this.icdCode});
  Diagnostic.instance();
  @override
  String toString() => name;
  Diagnostic fromJson(Map<String, dynamic> json) {
    return _$DiseaseStatusFromJson(json);
  }

  factory Diagnostic.fromJson(Map<String, dynamic> json) =>
      _$DiseaseStatusFromJson(json);
  Map<String, dynamic> toJson() => _$DiseaseStatusToJson(this);

  @override
  List<Object> get props => [name];
}
