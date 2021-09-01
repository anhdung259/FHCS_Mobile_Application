import 'package:fhcs_mobile_application/controller/account/account_controller.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeNewPasswordBody extends StatelessWidget {
  // const AccountBody({Key key}) : super(key: key);

  final AccountController ac = Get.find();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: ac.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.09,
          horizontal: SizeConfig.screenWidth * 0.08,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoxInput(
              title: OLDPASS,
              child: RoundedPasswordField(
                showIcon: false,
                borderColor: grey,
                controller: ac.oldPassController,
              ),
            ),
            BoxInput(
              //  required: false,
              title: NEWPASS,
              child: RoundedPasswordField(
                showIcon: false,
                borderColor: grey,
                controller: ac.newPassController,
                onChanged: (value) {
                  ac.newpass.value = value;
                },
              ),
            ),
            Obx(() => BoxInput(
                  title: CONFIRMPASS,
                  child: RoundedPasswordField(
                    showIcon: false,
                    borderColor: grey,
                    controller: ac.confirmPassController,
                    passwordConfirm: ac.newpass.value,
                  ),
                )),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            RoundedButton(
              sizeWidth: Get.width,
              text: "Đổi mật khẩu",
              press: () {
                ac.changePassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}
