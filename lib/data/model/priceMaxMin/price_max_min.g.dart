// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_max_min.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceMaxMin _$PriceMaxMinFromJson(Map<String, dynamic> json) {
  return PriceMaxMin(
    priceMax: (json['priceMax'] as num)?.toDouble(),
    priceMin: (json['priceMin'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PriceMaxMinToJson(PriceMaxMin instance) =>
    <String, dynamic>{
      'priceMax': instance.priceMax,
      'priceMin': instance.priceMin,
    };
