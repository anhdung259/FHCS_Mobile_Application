import 'package:fhcs_mobile_application/screens/splash/components/splash_body.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(child: SplashBody()),
    );
  }

  @override
  void initState() {
    super.initState();
    GeneralHelper.delayTimeAndCallback(2000, () async {
      var isloggedIn =
          await GeneralHelper.getValueSharedPreferences("isloggedIn");
      if (isloggedIn == null) {
        isloggedIn = false;
      }
      // Get.offNamed("/home");
      Get.offNamed(isloggedIn ? "/home" : "/login");
      // GeneralHelper.navigateToScreen(
      //     isloggedIn ? HomeScreen() : LoginScreen(), true);
    });
  }
}
