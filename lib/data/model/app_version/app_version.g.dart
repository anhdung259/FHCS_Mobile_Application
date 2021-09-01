// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersion _$AppVersionFromJson(Map<String, dynamic> json) {
  return AppVersion(
    id: json['id'] as String,
    version: json['version'] as String,
    creatAt: json['creatAt'] as String,
    urlDownload: json['urlDownload'] as String,
  );
}

Map<String, dynamic> _$AppVersionToJson(AppVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
      'urlDownload': instance.urlDownload,
      'creatAt': instance.creatAt,
      'id': instance.id,
    };
