import 'package:fhcs_mobile_application/controller/account/account_controller.dart';
import 'package:fhcs_mobile_application/screens/account/components/profile_pic.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInfoBody extends StatelessWidget {
  // const AccountBody({Key key}) : super(key: key);
  final AccountController ac = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.04,
          horizontal: SizeConfig.screenWidth * 0.06,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePic(
              imgUrl: ac.accountInfo.value.photoUrl,
            ),
            SizedBox(
              height: getProportionateScreenHeight(35),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  DisplayDetails(
                    title: CODEPATIENT,
                    info: ac.accountInfo.value.internalCode ?? NOINFO,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  DisplayDetails(
                    title: NAME_PROFILE,
                    info: ac.accountInfo.value.displayName ?? NOINFO,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  DisplayDetails(
                    title: DESCRIPTION,
                    info: ac.accountInfo.value.description ?? NOINFO,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  DisplayDetails(
                    title: PHONE_NUMBER,
                    info: ac.accountInfo.value.phoneNumber ?? NOINFO,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  DisplayDetails(
                    title: EMAIL,
                    info: ac.accountInfo.value.email ?? NOINFO,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
