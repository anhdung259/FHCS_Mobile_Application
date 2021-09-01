import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  int id;
  String statusImportMedicine;
  Status({this.id, this.statusImportMedicine});

  Status.instance();
  Status fromJson(Map<String, dynamic> json) {
    return _$StatusFromJson(json);
  }

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
