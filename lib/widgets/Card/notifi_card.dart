import 'package:fhcs_mobile_application/data/model/notificationSearch/notificationSearch.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'info_line.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key key, this.press, this.notificationServer})
      : super(key: key);

  final Function press;
  final NotificationSearch notificationServer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          press();
        },
        child: Opacity(
            opacity: notificationServer.isClicked == null
                ? 1
                : notificationServer.isClicked
                    ? 0.5
                    : 1,
            child: BackGroundCard(
              child: Row(
                //  direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(18),
                          right: getProportionateScreenWidth(17)),
                      child: SvgPicture.network(
                        GeneralHelper.checkDisplayIcon(
                            notificationServer.data.action),
                        height: getProportionateScreenHeight(35),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // DisplayInfo(
                        LineFlex(
                          text: notificationServer.notification.title,
                          textStyle: AppTheme.titleNotifi,
                        ),
                        //   textStyle: AppTheme.titleNotifi,
                        //   title: notificationServer.notification.title,
                        // ),
                        LineFlex(
                          text: notificationServer.notification.body,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            GeneralHelper.formatFullDateText(
                                notificationServer.createAt),
                            style: AppTheme.date,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
