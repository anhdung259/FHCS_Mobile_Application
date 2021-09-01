import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  int limit;
  int page;
  int totalRecord;
  Info({int json, this.limit, this.page, this.totalRecord});

  Info.instance();
  Info fromJson(Map<String, dynamic> json) {
    return _$InfoFromJson(json);
  }

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
