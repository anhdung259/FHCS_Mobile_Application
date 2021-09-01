// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Info _$InfoFromJson(Map<String, dynamic> json) {
  return Info(
    limit: json['limit'] as int,
    page: json['page'] as int,
    totalRecord: json['totalRecord'] as int,
  );
}

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'totalRecord': instance.totalRecord,
    };
