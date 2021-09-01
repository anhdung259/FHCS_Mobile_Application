import 'package:json_annotation/json_annotation.dart';
part 'token_forgot_password.g.dart';

@JsonSerializable()
class TokenForgotPassword {
  String tokenForgotPassword;
  TokenForgotPassword({this.tokenForgotPassword});
  TokenForgotPassword.instance();
  TokenForgotPassword fromJson(Map<String, dynamic> json) {
    return _$TokenForgotPasswordFromJson(json);
  }

  factory TokenForgotPassword.fromJson(Map<String, dynamic> json) =>
      _$TokenForgotPasswordFromJson(json);
}

// class ResponseServer2 {
//   List<dynamic> data;
//   String message;
//   int statusCode;
//   ResponseServer2({this.data, this.message, this.statusCode});
//   factory ResponseServer2.fromJson2(Map<String, dynamic> json) =>
//       _$ResponseServerFromJson2(json);
// }
