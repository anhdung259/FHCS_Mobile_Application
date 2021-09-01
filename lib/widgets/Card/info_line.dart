import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DisplayInfo extends StatelessWidget {
  const DisplayInfo({
    Key key,
    this.title,
    this.info,
    this.textStyle = AppTheme.infoPrescription,
    this.widthSize,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);
  final String title;
  final String info;
  final TextStyle textStyle;
  final double widthSize;
  final TextOverflow overflow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
      child: Container(
        width: widthSize ?? SizeConfig.screenWidth * 0.57,
        child: Row(
          children: [
            Text(title ?? "", style: AppTheme.titleDetail),
            SizedBox(
              width: 3,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                info,
                style: textStyle,
                overflow: overflow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineFlex extends StatelessWidget {
  const LineFlex({
    Key key,
    @required this.text,
    this.textStyle = AppTheme.normalText,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(text, style: textStyle),
          ),
        ],
      ),
    );
  }
}
