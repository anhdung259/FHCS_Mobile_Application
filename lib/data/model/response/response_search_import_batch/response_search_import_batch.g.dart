// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_search_import_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportBatchResponseSearch _$ImportBatchResponseSearchFromJson(
    Map<String, dynamic> json) {
  return ImportBatchResponseSearch(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ImportBatch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ImportBatchResponseSearchToJson(
        ImportBatchResponseSearch instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
