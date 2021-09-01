import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

import 'list_notification.dart';

class NotificationShowBody extends StatelessWidget {
  NotificationShowBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.01,
          horizontal: SizeConfig.screenWidth * 0.04,
        ),
        child: Column(
          children: [ListNotification()],
        ),
      ),
    );
  }
}
