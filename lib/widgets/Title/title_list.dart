import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/filter_button.dart';
import 'package:flutter/material.dart';

class TitleList extends StatelessWidget {
  const TitleList({
    Key key,
    this.title,
    this.optionText = false,
    this.press,
    this.showMore = false,
  }) : super(key: key);
  final String title;
  final bool optionText;
  final Function press;
  final bool showMore;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: getProportionateScreenHeight(17),
          bottom: getProportionateScreenHeight(3)),
      decoration: BoxDecoration(
          // border: Border(bottom: BorderSide(color: grey, width: 0.3)),
          ),
      child: Row(
        children: [
          Text(
            title,
            style: AppTheme.titleList,
          ),
          Spacer(),
          showMore
              ? InkWell(
                  onTap: press,
                  child: optionText == false
                      ? FilterButton(
                          onPress: press,
                        )
                      : Text(
                          "Xem thêm",
                          style: AppTheme.seemore,
                        ),
                )
              : Container(),
        ],
      ),
    );
  }
}
