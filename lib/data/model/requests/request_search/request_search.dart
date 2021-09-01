import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_search.g.dart';

@JsonSerializable()
class SearchRequest {
  int limit;
  int page;
  String sortField;
  int sortOrder;
  List<String> includes;
  List<String> groupBys;
  List<String> diagnosticIds;
  List<String> allergyIds;
  Map<String, ValueCompare> searchValue;
  String selectFields;

  SearchRequest(
      {this.limit,
      this.page,
      this.sortField,
      this.sortOrder,
      this.searchValue,
      this.selectFields,
      this.groupBys,
      this.includes,
      this.allergyIds,
      this.diagnosticIds});

  Map<String, dynamic> toJson() => _$SearchRequestToJson(this);
}
