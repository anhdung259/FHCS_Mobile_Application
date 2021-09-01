import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BoxInput extends StatelessWidget {
  const BoxInput({
    Key key,
    this.child,
    this.title,
    this.align = true,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.textStyle = AppTheme.titleDetail,
    this.required = true,
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool align;
  final TextStyle textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final bool required;
  @override
  Widget build(BuildContext context) {
    return align
        ? Padding(
            padding:
                EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '$title', style: textStyle),
                      TextSpan(
                          text: required ? ' * ' : ' ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              backgroundColor: white,
                              color: Colors.red)),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                child
              ],
            ),
          )
        : Padding(
            padding:
                EdgeInsets.symmetric(vertical: getProportionateScreenHeight(4)),
            child: Row(
              children: [
                Text(
                  title ?? "",
                  style: AppTheme.titleInput,
                ),
                SizedBox(
                  width: 5,
                ),
                child,
              ],
            ),
          );
  }
}

class BoxFilter extends StatelessWidget {
  const BoxFilter({
    Key key,
    this.child,
    this.title,
  }) : super(key: key);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.titleDetail,
        ),
        child
      ],
    );
  }
}
