// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periodic_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodicInventory _$PeriodicInventoryFromJson(Map<String, dynamic> json) {
  return PeriodicInventory(
    id: json['id'] as String,
    name: json['name'] as String,
    fromDate: json['fromDate'] as String,
    createDate: json['createDate'] as String,
    month: json['month'] as int,
    toDate: json['toDate'] as String,
    year: json['year'] as int,
  );
}

Map<String, dynamic> _$PeriodicInventoryToJson(PeriodicInventory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'month': instance.month,
      'year': instance.year,
      'createDate': instance.createDate,
    };
