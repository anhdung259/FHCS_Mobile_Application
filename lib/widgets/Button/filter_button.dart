import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key key,
    this.onPress,
  }) : super(key: key);
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            LineIcons.filter,
            size: getProportionateScreenHeight(38),
            color: KPrimaryColor.withOpacity(0.8),
          ),
          Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(13)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Lọc",
                style: AppTheme.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
