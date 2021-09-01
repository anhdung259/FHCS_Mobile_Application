import 'package:json_annotation/json_annotation.dart';
part 'begin_inventory.g.dart';

@JsonSerializable()
class BeginInventory {
  String id;
  int quantity;

  BeginInventory({this.id, this.quantity});
  BeginInventory.instance();
  BeginInventory fromJson(Map<String, dynamic> json) {
    return _$BeginInventoryFromJson(json);
  }

  factory BeginInventory.fromJson(Map<String, dynamic> json) =>
      _$BeginInventoryFromJson(json);
  Map<String, dynamic> toJson() => _$BeginInventoryToJson(this);
}
