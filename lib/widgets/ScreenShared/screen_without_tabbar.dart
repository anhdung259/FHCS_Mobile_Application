import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'no_internet.dart';

class ScreenWithoutTabBar extends StatefulWidget {
  const ScreenWithoutTabBar({
    Key key,
    @required this.title,
    @required this.body,
    this.onEdit,
    this.showFloatingButton = false,
    this.onDelete,
    this.button,
    this.loadingCall = false,
    this.function,
    this.onCancel,
    this.showButtonBack = false,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.miniEndFloat,
  }) : super(key: key);
  final String title;
  final Widget body;
  final Function onEdit;
  final Function onDelete;
  final Function onCancel;
  final bool showFloatingButton;
  final Widget button;
  final bool loadingCall;
  final Function function;
  final bool showButtonBack;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  @override
  _ScreenWithoutTabBarState createState() => _ScreenWithoutTabBarState();
}

class _ScreenWithoutTabBarState extends State<ScreenWithoutTabBar> {
  // @override
  // void initState() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     //   Get.dialog(Material(child: Text(message.data['id'])));
  //     widget.funtion();
  //   });
  //   super.initState();
  // }

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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: AppBar(
            // automaticallyImplyLeading: widget.showButtonBack,
            backgroundColor: KPrimaryColor,
            title: Text(
              widget.title,
              style: AppTheme.titleAppbar,
            ),
            leading: widget.showButtonBack
                ? new IconButton(
                    icon: new Icon(Icons.arrow_back, color: white),
                    onPressed: () {
                      // print("a");
                      widget.function();
                    },
                  )
                : null,
            actions: [
              widget.onEdit != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15)),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: widget.onEdit,
                        child: Icon(
                          Icons.edit,
                          size: getProportionateScreenWidth(25),
                        ),
                      ),
                    )
                  : Container(),
              widget.onDelete != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15)),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: widget.onEdit,
                        child: Icon(
                          Icons.delete,
                          size: getProportionateScreenWidth(25),
                        ),
                      ),
                    )
                  : Container(),
              // widget.onCancel != null
              //     ? Padding(
              //         padding: EdgeInsets.symmetric(
              //             horizontal: getProportionateScreenWidth(15)),
              //         child: InkWell(
              //           customBorder: CircleBorder(),
              //           onTap: widget.onCancel,
              //           child: Icon(
              //             Icons.clear,
              //             size: getProportionateScreenWidth(30),
              //           ),
              //         ),
              //       )
              //     : Container(),
            ]),
        body: ModalProgressHUD(
            inAsyncCall: widget.loadingCall,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(
              color: white,
            ),
            child: widget.body),
        // bottomNavigationBar: showFloatingButton != false ? button : null,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButton:
            widget.showFloatingButton != false ? widget.button : null,
      ),
    );
  }
}
