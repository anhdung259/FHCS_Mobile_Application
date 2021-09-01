import 'package:fhcs_mobile_application/controller/forgot_account/forgot_account_controller.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class SettingNewPassBody extends StatelessWidget {
  // const MedicineManagerBody({Key key}) : super(key: key);
  final ForgotAccountController fc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: fc.isLoading.value,
        opacity: 0.5,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.02,
              horizontal: SizeConfig.screenWidth * 0.04,
            ),
            child: Form(
              key: fc.submitNewPassKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxInput(
                    title: "Mật khẩu mới",
                    child: RoundedPasswordField(
                      borderColor: grey,
                      controller: fc.textNewPass,
                      onChanged: (value) {
                        fc.newpass.value = value;
                      },
                      showIcon: false,
                    ),
                  ),
                  Obx(() => BoxInput(
                        title: "Xác nhận mật khẩu",
                        child: RoundedPasswordField(
                          borderColor: grey,
                          controller: fc.textNewPassConfirm,
                          showIcon: false,
                          passwordConfirm: fc.newpass.value,
                        ),
                      )),
                  Center(
                    child: RoundedButton(
                      text: "Đặt lại mật khẩu",
                      press: () {
                        fc.changeNewPassword();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
