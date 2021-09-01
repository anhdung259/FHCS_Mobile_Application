import 'package:json_annotation/json_annotation.dart';

part 'price_max_min.g.dart';

@JsonSerializable()
class PriceMaxMin {
  double priceMax;
  double priceMin;

  PriceMaxMin({this.priceMax, this.priceMin});

  PriceMaxMin.instance();
  PriceMaxMin fromJson(Map<String, dynamic> json) {
    return _$PriceMaxMinFromJson(json);
  }

  factory PriceMaxMin.fromJson(Map<String, dynamic> json) =>
      _$PriceMaxMinFromJson(json);
}
