import 'package:json_annotation/json_annotation.dart';
part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  String accessToken;
  int provider;
  int fromAppLogin;
  String username;
  String password;
  String verifyCode;
  String oldPassword;
  String newPassword;
  String confirmNewPassword;
  String fcmToken;
  //google = 1; facebook=0
//fromAppLogin =0 web, =1 mobile
  AuthRequest(
      {this.accessToken,
      this.provider,
      this.fromAppLogin,
      this.fcmToken,
      this.username,
      this.oldPassword,
      this.password,
      this.newPassword,
      this.confirmNewPassword,
      this.verifyCode});

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
