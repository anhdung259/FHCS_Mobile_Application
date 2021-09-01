import 'package:json_annotation/json_annotation.dart';
part 'app_version.g.dart';

@JsonSerializable()
class AppVersion {
  String version;
  String urlDownload;
  String creatAt;
  String id;

  AppVersion({this.id, this.version, this.creatAt, this.urlDownload});
  AppVersion.instance();
  AppVersion fromJson(Map<String, dynamic> json) {
    return _$AppVersionFromJson(json);
  }

  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionToJson(this);
}
