import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

import 'splash_background.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                LOGOAPP,
                width: SizeConfig.screenWidth * 0.6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
