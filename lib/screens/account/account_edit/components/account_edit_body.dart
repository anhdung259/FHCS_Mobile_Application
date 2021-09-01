import 'package:fhcs_mobile_application/controller/account/account_controller.dart';
import 'package:fhcs_mobile_application/screens/account/components/profile_pic.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class AccountEditBody extends StatelessWidget {
  final AccountController ac = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => ac.backScreen(),
        child: ModalProgressHUD(
          inAsyncCall: ac.isLoading.value,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.04,
              horizontal: SizeConfig.screenWidth * 0.1,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfilePic(
                    pickImagePath: ac.avatarPathFile.value,
                    imgUrl: ac.accountInfo.value.photoUrl,
                    onEdit: () {
                      ac.getImage();
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(35),
                  ),
                  buildTextField(NAME_PROFILE, ac.textName),
                  buildTextField(DESCRIPTION, ac.textDes),
                  buildTextField(PHONE_NUMBER, ac.textPhoneNumber),
                  RoundedButton(
                    sizeWidth: Get.width,
                    text: "Sửa thông tin",
                    press: () {
                      ac.updateProfile();
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(50)),
      child: TextField(
        //obscureText: isPasswordTextField ? showPassword : false,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
                fontSize: 22, color: darkText, fontWeight: FontWeight.w600),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
