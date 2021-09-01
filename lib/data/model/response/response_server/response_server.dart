import 'package:json_annotation/json_annotation.dart';
part 'response_server.g.dart';

@JsonSerializable()
class ResponseServer {
  dynamic data;
  String message;
  int statusCode;
  ResponseServer({this.data, this.message, this.statusCode});
  factory ResponseServer.fromJson(Map<String, dynamic> json) =>
      _$ResponseServerFromJson(json);
}
