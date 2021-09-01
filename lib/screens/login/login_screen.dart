import 'package:fhcs_mobile_application/controller/login/login_controller.dart';
import 'package:fhcs_mobile_application/screens/login/components/login_button.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_username.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'components/or_divider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController lc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: lc.isLoadingLoggin.value,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: KColorBackground,
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30),
                    vertical: getProportionateScreenHeight(120)),
                child: Form(
                  key: lc.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.network(
                          LOGO,
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.55,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      RoundedUsernameField(
                        controller: lc.textUserController,
                        hintText: "Tên đăng nhập",
                        icon: Icons.person,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      RoundedPasswordField(
                        showShadow: true,
                        borderColor: white,
                        controller: lc.textPassController,
                        hintText: "Mật khẩu",
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed("/inputAccountVerify");
                          },
                          child: Text(
                            "Quên mật khẩu?",
                            style: AppTheme.normalText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      RoundedButton(
                        sizeWidth: Get.width,
                        color: KPrimaryColor,
                        textColor: white,
                        text: "Đăng nhập",
                        press: () {
                          lc.signInWithUserPass();
                        },
                      ),
                      OrDivider(),
                      LoginButton(
                        sizeWidth: Get.width,
                        press: () {
                          lc.signInWithGG();
                          // GeneralHelper.navigateToScreen(HomeScreen(), false);
                        },
                        icon: GOOGLE_ICON,
                        text: "Tiếp tục với Google",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )));
  }
}
