import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

class BackGroundComponent extends StatelessWidget {
  const BackGroundComponent({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //  physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(10),
            horizontal: getProportionateScreenWidth(10)),
        child: Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: kElevationToShadow[1],
              border: Border.all(width: 0.5, color: grey),
              // color: Theme.of(context).bottomAppBarColor,
            ),
            child: child),
      ),
    );
  }
}

class BackGroundCard extends StatelessWidget {
  const BackGroundCard({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(7),
            vertical: getProportionateScreenHeight(5)),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: grey, width: 0.5),
          ),
        ),
        child: child);
  }
}
