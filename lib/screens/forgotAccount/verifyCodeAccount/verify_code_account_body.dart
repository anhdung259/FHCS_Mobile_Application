import 'package:fhcs_mobile_application/controller/forgot_account/forgot_account_controller.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class VerifyCodeAccountBody extends StatelessWidget {
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
              key: fc.submitCodeKey,
              child: Column(
                children: [
                  Icon(
                    Icons.email,
                    color: KPrimaryColor,
                    size: getProportionateScreenHeight(50),
                  ),
                  Text(
                    "Chúng tôi đã gửi một mã xác nhận tới Email của bạn",
                    style: AppTheme.notify,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  RoundedInputField(
                    controller: fc.textCodeVerify,
                    hintText: "Mã xác nhận",
                    validate: fc.validator,
                    isNumber: true,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  RoundedButton(
                    text: "Xác minh mã",
                    press: () {
                      fc.verifyCode();
                    },
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
