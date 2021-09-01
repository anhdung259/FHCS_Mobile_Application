import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color backgroundColor, iconColor;
  final Function onPressed;

  const CircleButton({
    Key key,
    @required this.icon,
    @required this.iconSize,
    this.backgroundColor = KPrimaryColor,
    this.iconColor = white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: kElevationToShadow[1],
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        color: iconColor,
        onPressed: onPressed,
      ),
    );
  }
}
