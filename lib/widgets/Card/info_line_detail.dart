import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class DisplayDetails extends StatelessWidget {
  const DisplayDetails({
    Key key,
    @required this.title,
    @required this.info,
    this.textStyle = AppTheme.infoPrescription,
  }) : super(key: key);
  final String title;
  final String info;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTheme.titleDetail),
            SizedBox(
              width: getProportionateScreenWidth(30),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                info,
                style: textStyle,
                textAlign: TextAlign.right,
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageSignature extends StatelessWidget {
  const ImageSignature({
    Key key,
    @required this.title,
    @required this.src,
    this.msg,
  }) : super(key: key);
  final String title;
  final String msg;
  final String src;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTheme.titleDetail),
            src.isNotEmpty || src == null
                ? FadeInImage.assetNetwork(
                    placeholder: cupertinoActivityIndicator,
                    image: src,
                    height: getProportionateScreenHeight(65),
                    width: getProportionateScreenWidth(85),
                    placeholderScale: 7)
                : Text(
                    msg,
                    style: AppTheme.infoPrescription,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
          ],
        ),
      ),
    );
  }
}
