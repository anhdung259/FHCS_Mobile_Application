import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;
  final Color color;

  CustomAppBar({@required this.child, this.height, this.color});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: KPrimaryColor,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      height: preferredSize.height,
      // alignment: Alignment.center,
      child: child,
    );
  }
}
