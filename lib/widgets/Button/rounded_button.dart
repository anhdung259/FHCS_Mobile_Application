import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final double sizeWidth;
  final double sizeHeight;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.sizeWidth,
    this.sizeHeight,
    this.color = KPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeHeight,
      width: sizeWidth,
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[1],
          color: color,
          border: Border.all(width: 3.0, color: KPrimaryColor),
          borderRadius: BorderRadius.circular(10)),

      // ignore: deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(4),
            horizontal: getProportionateScreenWidth(25)),
        onPressed: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          press?.call();
        },
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      ),
    );
  }
}

class RoundedButtonInsert extends StatelessWidget {
  final String text;
  final Function press;
  final double sizeWidth;
  final double sizeHeight;
  final Color color, textColor;
  const RoundedButtonInsert({
    Key key,
    this.text,
    this.press,
    this.sizeWidth = 0.8,
    this.sizeHeight,
    this.color = KPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeHeight,
      width: sizeWidth,
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[1],
          color: color,
          border: Border.all(width: 1.0, color: KPrimaryColor),
          borderRadius: BorderRadius.circular(10)),

      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          press();
        },
        child: Text(
          text,
          style: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
