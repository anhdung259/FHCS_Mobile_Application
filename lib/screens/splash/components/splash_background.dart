import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.network(
              TOPRIGHT,
              width: SizeConfig.screenWidth * 0.4,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.network(
              BOTTOMLEFT,
              width: SizeConfig.screenWidth * 0.4,
            ),
          ),
          child
        ],
      ),
    );
  }
}
