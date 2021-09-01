import 'package:fhcs_mobile_application/data/model/requests/auth_request/auth_request.dart';
import 'package:fhcs_mobile_application/data/repository/forgot_password_repository.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotAccountController extends GetxController {
  final ForgotPasswordRepository repository;
  ForgotAccountController({@required this.repository})
      : assert(repository != null);
  TextEditingController textUsernameVerify = TextEditingController();
  TextEditingController textCodeVerify = TextEditingController();
  TextEditingController textNewPass = TextEditingController();
  TextEditingController textNewPassConfirm = TextEditingController();
  var newpass = "".obs;
  var notifyBugSendCode = true.obs;
  var notifyVerifyCode = true.obs;
  var isLoading = false.obs;
  GlobalKey<FormState> submitUsernameKey = GlobalKey<FormState>();
  GlobalKey<FormState> submitCodeKey = GlobalKey<FormState>();
  GlobalKey<FormState> submitNewPassKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    textNewPass.dispose();
    textNewPassConfirm.dispose();
    textCodeVerify.dispose();
    textUsernameVerify.dispose();
  }

  void sendCodeVerify() async {
    if (submitUsernameKey.currentState.validate()) {
      isLoading(true);
      try {
        var result = await repository
            .sendCode(AuthRequest(username: textUsernameVerify.text));
        if (result.statusCode == 200) {
          GeneralHelper.saveToSharedPreferences(
              "token", result.data.tokenForgotPassword);
          isLoading(false);
          Get.toNamed("/verifyCodeAccount");
          // GeneralHelper.saveToSharedPreferences("isloggedIn", true);
        } else {
          //  print("bug");
          isLoading(false);
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        isLoading(false);
        print(e);
      }
    }
  }

  void verifyCode() {
    if (submitCodeKey.currentState.validate()) {
      isLoading(true);
      GeneralHelper.checkTokenExpiration().then((value) async {
        if (value != false) {
          isLoading(false);
          showNotifiExpriedToken();
        } else {
          try {
            var result = await repository.verifyCodeAccount(
                AuthRequest(verifyCode: textCodeVerify.text));
            if (result.statusCode == 200) {
              print(result.data);
              isLoading(false);
              Get.toNamed("/settingNewPass");
              // GeneralHelper.saveToSharedPreferences("isloggedIn", true);
            } else {
              isLoading(false);
              GeneralHelper.showMessage(msg: 'Mã xác nhận không chính xác');
              print("bug");
            }
          } on Exception catch (e) {
            isLoading(false);
            print(e);
          }
        }
      });
    }
  }

  showNotifiExpriedToken() {
    GeneralHelper.showMessage(
        msg: 'Mã xác nhận đã hết hạn, vui lòng gửi lại mã',
        press: () => Get.offNamedUntil(
            "/inputAccountVerify", ModalRoute.withName('/inputAccountVerify')));
  }

  void changeNewPassword() async {
    if (submitNewPassKey.currentState.validate()) {
      isLoading(true);
      GeneralHelper.checkTokenExpiration().then((value) async {
        if (value != false) {
          isLoading(false);
          showNotifiExpriedToken();
        } else {
          try {
            var result = await repository.changeForgotPassword(AuthRequest(
                newPassword: textNewPass.text,
                confirmNewPassword: textNewPassConfirm.text));
            if (result.statusCode == 200) {
              print(result.data);
              isLoading(false);
              Navigator.of(Get.context).popUntil(ModalRoute.withName("/login"));
              GeneralHelper.showMessage(msg: "Đổi mật khẩu thành công.");
              // GeneralHelper.saveToSharedPreferences("isloggedIn", true);
            } else {
              isLoading(false);
              GeneralHelper.showMessage(msg: result.message);
            }
          } on Exception catch (e) {
            print(e);
          }
        }
      });
    }
  }

  String validator(String value) {
    if (value.isEmpty) {
      return 'Thông tin bắt buộc';
    }
    return null;
  }
}
