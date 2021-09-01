import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class IconManagerButton extends StatelessWidget {
  const IconManagerButton({
    Key key,
    this.text,
    this.imgUrl,
    this.press,
  }) : super(key: key);
  final String text;
  final String imgUrl;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              // border: Border.all(width: 2, color: white),
              boxShadow: kElevationToShadow[1],
              color: white,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              imgUrl,
              height: getProportionateScreenHeight(30),
              width: getProportionateScreenWidth(30),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          // Text("Quản lý", style: AppTheme.headline),
          Text(text, style: AppTheme.headline),
        ],
      ),
    );
  }
}
