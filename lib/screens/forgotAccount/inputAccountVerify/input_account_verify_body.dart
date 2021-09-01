import 'package:fhcs_mobile_application/controller/forgot_account/forgot_account_controller.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class InputAccountVerifyBody extends StatelessWidget {
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
                vertical: SizeConfig.screenHeight * 0.06,
                horizontal: SizeConfig.screenWidth * 0.07,
              ),
              child: Form(
                key: fc.submitUsernameKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Vui lòng nhập tài khoản bạn muốn lấy mật khẩu",
                      style: AppTheme.normalText,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    RoundedInputField(
                      controller: fc.textUsernameVerify,
                      hintText: "Tài khoản",
                      validate: fc.validator,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    RoundedButton(
                      text: "Tiếp tục",
                      press: () {
                        fc.sendCodeVerify();
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
