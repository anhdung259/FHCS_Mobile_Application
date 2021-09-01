// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseServer _$ResponseServerFromJson(Map<String, dynamic> json) {
  return ResponseServer(
    data: json['data'],
    message: json['message'] as String,
    statusCode: json['statusCode'] as int,
  );
}

Map<String, dynamic> _$ResponseServerToJson(ResponseServer instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
