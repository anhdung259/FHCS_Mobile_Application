import 'package:json_annotation/json_annotation.dart';
part 'value_compare.g.dart';

@JsonSerializable()
class ValueCompare {
  String value;
  dynamic compare;

  ValueCompare({
    this.value,
    this.compare,
  });

  Map<String, dynamic> toJson() => _$ValueCompareToJson(this);
}
