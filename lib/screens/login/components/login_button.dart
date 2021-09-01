import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function press;
  final double sizeWidth;
  final double sizeHeight;
  final Color color, textColor;
  final String icon;
  const LoginButton({
    Key key,
    this.text,
    this.press,
    this.sizeWidth = 0.8,
    this.sizeHeight,
    this.color = white,
    this.textColor = darkText,
    this.icon,
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
          border: Border.all(width: 3.0, color: white),
          borderRadius: BorderRadius.circular(10)),

      // ignore: deprecated_member_use
      child: FlatButton.icon(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(5),
        ),
        color: color,
        onPressed: press,
        label: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        icon: SvgPicture.network(
          icon,
          height: getProportionateScreenHeight(24),
        ),
      ),
    );
  }
}
