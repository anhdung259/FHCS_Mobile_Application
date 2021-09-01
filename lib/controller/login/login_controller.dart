import 'package:fhcs_mobile_application/data/model/requests/auth_request/auth_request.dart';
import 'package:fhcs_mobile_application/data/repository/login_repository.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';

import 'package:fhcs_mobile_application/shared/service/auth_social_firebase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;
  LoginController({@required this.loginRepository});
  TextEditingController textUserController = TextEditingController();
  TextEditingController textPassController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var isValidUserName = true.obs;
  var isValidPass = true.obs;
  var isLoadingLoggin = false.obs;

  void signInWithGG() async {
    var fcmtoken;
    FirebaseMessaging.instance.getToken().then((value) => fcmtoken = value);
    signInWithGoogle().then((value) {
      isLoadingLoggin(true);
      loginRepository
          .authUserGoogle(new AuthRequest(
              accessToken: value,
              provider: 1,
              fromAppLogin: 1,
              fcmToken: fcmtoken))
          .then(
        (response) {
          print(response.statusCode);
          if (response.statusCode != 200) {
            signOutGoogle();
            isLoadingLoggin(false);
            GeneralHelper.showMessage(msg: response.message);
          } else {
            isLoadingLoggin(false);
            //account = response.data;
            print('token Login Google: ' + response.data.token);
            // addHeader('Authorization', 'Bearer ' + response.data.token);
            GeneralHelper.saveToSharedPreferences("token", response.data.token);
            GeneralHelper.saveToSharedPreferences("loginWith", "google");
            saveLocalStorage();
            Get.offAllNamed("/home");
            // isLoadingLoggin(false);
            // GeneralHelper.getValueSharedPreferences("token");
          }
        },
      );
    });
  }

  String validator(String value) {
    if (value.isEmpty) {
      return 'Vui lòng không để trống';
    }
    return null;
  }

  void validateData() {
    if (textUserController.text.isEmpty) {
      isValidUserName(false);
    } else {
      isValidUserName(true);
    }

    if (textPassController.text.isEmpty) {
      isValidPass(false);
    } else {
      isValidPass(true);
    }
  }

  String validateUserLogin(String value) {
    if (value.isEmpty) {
      return "Hãy nhập tên tài khoản";
    }
    return null;
  }

  String validatePasswordLogin(String value) {
    if (value.isEmpty) {
      return "Hãy nhập mật khẩu";
    }
    return null;
  }

  void signInWithUserPass() async {
    var fcmtoken;
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => fcmtoken = value);

    if (loginFormKey.currentState.validate()) {
      isLoadingLoggin(true);
      loginRepository
          .authUsernamePassword(new AuthRequest(
              username: textUserController.text,
              password: textPassController.text,
              fromAppLogin: 1,
              fcmToken: fcmtoken))
          .then(
        (response) {
          print(response.message);
          if (response.statusCode != 200) {
            isLoadingLoggin(false);
            GeneralHelper.showMessage(msg: response.message);
          } else {
            isLoadingLoggin(false);
            //account = response.data;
            print('token Login Google: ' + response.data.token);
            // addHeader('Authorization', 'Bearer ' + response.data.token);
            GeneralHelper.saveToSharedPreferences("token", response.data.token);
            GeneralHelper.saveToSharedPreferences(
                "loginWith", "usernamePassword");
            saveLocalStorage();
            Get.offNamed("/home");
          }
        },
      );
    }
  }

  void saveLocalStorage() {
    GeneralHelper.saveToSharedPreferences("isloggedIn", true);
    GeneralHelper.saveToSharedPreferences("active", true);
  }

  void signOut() async {
    GeneralHelper.clearLocalStorage("isloggedIn");
    GeneralHelper.clearLocalStorage("token");
    GeneralHelper.clearLocalStorage("loginWith");
    signOutGoogle().then((value) => Get.offAllNamed("/login"));
  }

  void showConfirmLogOut() {
    GeneralHelper.showConfirm(
      title: "Bạn có chắc chắn muốn đăng xuất?",
      msg: "",
      pressCancel: () {},
      textCancel: "Không",
      textOk: "Đồng ý",
      pressOk: () {
        signOut();
        // Get.back();
      },
    );
  }
}
