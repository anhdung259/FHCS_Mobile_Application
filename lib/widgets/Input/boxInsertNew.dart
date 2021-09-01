import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BoxInsertNew extends StatelessWidget {
  const BoxInsertNew({
    Key key,
    this.press,
  }) : super(key: key);
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: KPrimaryColor),
              child: Icon(
                Icons.add,
                color: white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text("Thêm mới", style: AppTheme.primaryColor),
          ],
        ),
      ),
    );
  }
}
