import 'package:fhcs_mobile_application/bindings/initialBinding.dart';
import 'package:fhcs_mobile_application/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'shared/share_variables/constants.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   final style = SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //   );

  //   SystemChrome.setSystemUIOverlayStyle(style);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerBuilder: () => MaterialClassicHeader(),
        footerBuilder: () => ClassicFooter(
          loadingText: "Đang tải...",
          canLoadingText: "Kéo lên để tải thêm",
          idleText: "Tải xong",
        ),
        enableLoadingWhenNoData: false,
        enableRefreshVibrate: false,
        enableLoadMoreVibrate: false,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return false;
        },
        child: GetMaterialApp(
          builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
          ),
          localizationsDelegates: [GlobalMaterialLocalizations.delegate],
          supportedLocales: [
            const Locale('en'),
            const Locale('vi'),
          ],
          localeResolutionCallback:
              (Locale locale, Iterable<Locale> supportedLocales) {
            //print("change language");
            return locale;
          },
          initialBinding: InitialBinding(),
          enableLog: true,
          debugShowCheckedModeBanner: false,
          title: "FHCS",
          theme: ThemeData(
            primaryColor: KPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: "/splash",
          getPages: routes(),
        ),
      ),
    );
  }
}
