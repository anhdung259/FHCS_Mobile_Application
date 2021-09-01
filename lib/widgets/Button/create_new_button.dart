import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Circle/circle_button.dart';
import 'package:flutter/material.dart';

class CreatNewButton extends StatelessWidget {
  const CreatNewButton({
    Key key,
    this.onPress,
  }) : super(key: key);
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleButton(
          backgroundColor: KPrimaryColor,
          icon: Icons.add,
          iconColor: white,
          iconSize: getProportionateScreenHeight(38),
          onPressed: () async {
            onPress();
            // mc.navigatorInsertMedicine();
            // GeneralHelper.navigateToScreen(InsertMedicine(), false);
          },
        ),
      ],
    );
  }
}
