import 'package:fhcs_mobile_application/data/model/medicine/medicine.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine_inventory_result_search.g.dart';

@JsonSerializable()
class MedicineInventoryResultSearch {
  String id;
  String name;
  int quantity;
  double price;
  String insertDate;
  String expirationDate;
  String unitName;
  int month;
  int year;
  String medicineId;
  Medicine medicine;
  bool groupByCheck;
  List<GroupByChoiceMedicine> groupByChoiceMedicine;
  MedicineInventoryResultSearch(
      {this.id,
      this.name,
      this.quantity = 0,
      this.insertDate,
      this.month,
      this.year,
      this.unitName,
      this.expirationDate,
      this.medicineId,
      this.medicine,
      this.price,
      this.groupByChoiceMedicine,
      this.groupByCheck});

  MedicineInventoryResultSearch.instance();
  MedicineInventoryResultSearch fromJson(Map<String, dynamic> json) {
    return _$MedicineInventoryResultSearchFromJson(json);
  }

  factory MedicineInventoryResultSearch.fromJson(Map<String, dynamic> json) =>
      _$MedicineInventoryResultSearchFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineInventoryResultSearchToJson(this);
}

class GroupByChoiceMedicine {
  String medicineInventoryId;
  int quantity;
  GroupByChoiceMedicine({this.medicineInventoryId, this.quantity});
  GroupByChoiceMedicine.instance();
}
