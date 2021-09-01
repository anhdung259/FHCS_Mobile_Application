import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

class BackGroundTextField extends StatelessWidget {
  const BackGroundTextField({
    Key key,
    this.child,
    this.sizeWidth,
    this.backgroundColor = white,
    this.sizeheight,
    this.borderColor = grey,
    this.boxShawdow = false,
  }) : super(key: key);
  final Widget child;
  final double sizeWidth;
  final double sizeheight;
  final Color backgroundColor;
  final Color borderColor;
  final bool boxShawdow;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: sizeWidth,
        height: sizeheight,
        //  margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight()),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: boxShawdow ? kElevationToShadow[1] : null,
          border: Border.all(
              color: borderColor,
              // set border colo
              width: 1),
          // set border width
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // set rounded corner radius
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(4),
              horizontal: getProportionateScreenWidth(5)),
          child: child,
        ));
  }
}
