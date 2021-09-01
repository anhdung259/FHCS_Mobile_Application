import 'package:json_annotation/json_annotation.dart';
part 'periodic_inventory.g.dart';

@JsonSerializable()
class PeriodicInventory {
  String id;
  String name;
  String fromDate;
  String toDate;
  int month;
  int year;
  String createDate;
  // @override
  // String toString() => name;
  PeriodicInventory(
      {this.id,
      this.name,
      this.fromDate,
      this.createDate,
      this.month,
      this.toDate,
      this.year});
  PeriodicInventory.instance();
  PeriodicInventory fromJson(Map<String, dynamic> json) {
    return _$PeriodicInventoryFromJson(json);
  }

  factory PeriodicInventory.fromJson(Map<String, dynamic> json) =>
      _$PeriodicInventoryFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodicInventoryToJson(this);
}
