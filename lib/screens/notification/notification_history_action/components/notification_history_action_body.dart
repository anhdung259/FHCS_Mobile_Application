import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

import 'list_notification_history_action.dart';

class NotificationHistoryActionBody extends StatelessWidget {
  NotificationHistoryActionBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.02,
          horizontal: SizeConfig.screenWidth * 0.03,
        ),
        child: Column(
          children: [ListHistoryAction()],
        ),
      ),
    );
  }
}
