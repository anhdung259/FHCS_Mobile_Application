import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ListEmpty extends StatelessWidget {
  const ListEmpty({
    Key key,
    this.text = "Danh sách trống",
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            EMPTYLIST,
            height: getProportionateScreenHeight(150),
          ),
          Text(
            text,
            style: AppTheme.blurred,
          )
        ],
      ),
    );
  }
}
