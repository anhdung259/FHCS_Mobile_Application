import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'no_internet.dart';

class ScreenDetails extends StatelessWidget {
  const ScreenDetails({
    Key key,
    @required this.title,
    @required this.body,
    this.onEdit,
    this.onDelete,
    this.showDelete = true,
    this.showEdit = true,
    this.loadingCall = false,
    this.showFloatingButton = false,
    this.button,
  }) : super(key: key);
  final String title;
  final Widget body;
  final Function onEdit;
  final Function onDelete;
  final bool showDelete;
  final bool showEdit;
  final bool loadingCall;
  final Widget button;
  final bool showFloatingButton;
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
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          title: Text(
            title,
            style: AppTheme.titleAppbar,
          ),
          actions: [
            showEdit == true
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15)),
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: onEdit,
                      child: Icon(
                        Icons.edit,
                        size: getProportionateScreenWidth(25),
                      ),
                    ),
                  )
                : Container(),
            showDelete == true
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: onDelete,
                      child: Icon(
                        Icons.delete,
                        size: getProportionateScreenWidth(25),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        body: ModalProgressHUD(
            inAsyncCall: loadingCall,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(
              color: white,
            ),
            child: body),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: showFloatingButton == false ? button : null,
      ),
    );
  }
}
