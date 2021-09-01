import 'dart:convert';
import 'package:fhcs_mobile_application/controller/account/account_controller.dart';
import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/controller/login/login_controller.dart';
import 'package:fhcs_mobile_application/controller/notification/notificationController.dart';
import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/data_notification/data_notification.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/insert_treatment_info.dart';
import 'package:fhcs_mobile_application/screens/account/account.dart';
import 'package:fhcs_mobile_application/screens/history/history_patient/history_patient.dart';
import 'package:fhcs_mobile_application/screens/home/components/home_body.dart';
import 'package:fhcs_mobile_application/screens/notification/notification_show/notification_show.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/service/push_notification_manager.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/no_internet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TreatmentInfoController tic = Get.find();
  final HistoryController hc = Get.find();
  final NotificationController nc = Get.find();
  final SettingController sc = Get.find();
  final AccountController ac = Get.find();
  final LoginController lc = Get.find();
  DateTime currentBackPressTime;
  @override
  void initState() {
    sc.checkNewVersion(showMsgNewVersion: false);
    GeneralHelper.showTokenExpirationLoginAgain();
    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final data = jsonEncode(message.data);
        var dataNotification = DataNotification.fromJson(jsonDecode(data));
        LocalNotificationService.navigartorNotication(
            dataNotification, true, true, dataNotification.notificationId);
      }
    });

    ///forground work
    ///
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
        nc.fetchNotifiList();
        LocalNotificationService.display(message);
        final data = jsonEncode(message.data);
        var dataNotification = DataNotification.fromJson(jsonDecode(data));
        LocalNotificationService.navigartorNotication(
            dataNotification, false, true, dataNotification.notificationId);
      }
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final data = jsonEncode(message.data);
      var dataNotification = DataNotification.fromJson(jsonDecode(data));

      LocalNotificationService.navigartorNotication(
          dataNotification, true, false, dataNotification.notificationId);
    });

    super.initState();
  }

  void onTabTapped(int index) {
    switch (index) {
      case 0:
        tic.fetchTreatmentInfoRecently();
        break;
      case 1:
        tic.showEdit = false;
        tic.getTimeNow();
        break;
      case 2:
        hc.refreshListPatient();
        break;
      case 3:
        break;
    }
    setState(() {
      nc.currentIndex.value = index;
    });
  }

  Widget _body() {
    return Stack(
      children: List<Widget>.generate(5, (int index) {
        return IgnorePointer(
          ignoring: index != nc.currentIndex.value,
          child: Opacity(
            opacity: nc.currentIndex.value == index ? 1.0 : 0.0,
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return new MaterialPageRoute(
                  builder: (_) => _page(index),
                  settings: settings,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _page(int index) {
    switch (index) {
      case 0:
        return HomeBody();
        break;
      case 1:
        return InsertTreatmentInfo();
        break;
      case 2:
        return HistoryPatient();
        break;
      case 3:
        return AccountScreen();
        break;
      case 4:
        return NotificationShow();
        break;
    }
    throw "Invalid index $index";
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (nc.currentIndex.value != 0) {
      //currentBackPressTime = now;
      nc.currentIndex.value = 0;

      return Future.value(false);
    } else if (nc.currentIndex.value == 0 &&
        (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2))) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Nhấn lần nữa để thoát");
      return Future.value(false);
      //  return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: Duration.zero,
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            body: NoInternet(),
          );
        }
        return child;
      },
      child: Obx(() => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: white,
            body: WillPopScope(onWillPop: onWillPop, child: _body()), // new
            bottomNavigationBar: Container(
              height: SizeConfig.screenHeight * 0.07,
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: grey,
                    offset: Offset(
                      1, // Move to right 10  horizontally
                      0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: SafeArea(
                child: BottomNavigationBar(
                  backgroundColor: white,
                  unselectedLabelStyle: AppTheme.textBottomTab,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: grey,
                  selectedItemColor: KPrimaryColor,
                  selectedLabelStyle: AppTheme.textBottomTab,
                  onTap: onTabTapped, // new
                  currentIndex: nc.currentIndex.value > 3
                      ? 0
                      : nc.currentIndex.value, // new
                  items: [
                    new BottomNavigationBarItem(
                      icon: CustomIcon(
                        HOME,
                      ),
                      label: 'Home',
                    ),
                    new BottomNavigationBarItem(
                        icon: CustomIcon(
                          ADD_TREATMENT,
                        ),
                        label: 'Tạo đơn'),
                    new BottomNavigationBarItem(
                        icon: CustomIcon(
                          HISTORY,
                        ),
                        label: 'Lịch sử'),
                    new BottomNavigationBarItem(
                        icon: CustomIcon(
                          ACCOUNT,
                        ),
                        label: 'Tài khoản')
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon(
    this.name, {
    Key key,
    this.size,
    this.color,
  }) : super(key: key);

  final String name;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;

    if (iconOpacity != 1.0)
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    return Image.network(
      name,
      color: iconColor,
      height: getProportionateScreenHeight(25),
    );
  }
}
