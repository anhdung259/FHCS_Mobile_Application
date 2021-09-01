// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'begin_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeginInventory _$BeginInventoryFromJson(Map<String, dynamic> json) {
  return BeginInventory(
    id: json['id'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$BeginInventoryToJson(BeginInventory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
    };
