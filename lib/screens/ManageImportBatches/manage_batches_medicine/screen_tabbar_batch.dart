import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class BatchMedicineManage extends StatelessWidget {
  const BatchMedicineManage({
    Key key,
    this.title,
    this.onEdit,
    // this.showFloatingButton = false,
    this.onDelete,
    this.importBatch,
    this.inventorBatch,
    this.loadingCall = false,
    this.initialPage = 0,
  }) : super(key: key);
  final String title;
  final Function onEdit;
  final Function onDelete;
  final bool loadingCall;
  final Widget importBatch;
  final Widget inventorBatch;
  final int initialPage;

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
      child: DefaultTabController(
        initialIndex: initialPage,
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false, // this is new
          // this is new
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: KPrimaryColor,
            elevation: 8,
            brightness: Brightness.light,
            title: Text(
              title,
              style: AppTheme.titleAppbar,
            ),
            bottom: TabBar(
              physics: NeverScrollableScrollPhysics(),
              labelColor: white,
              indicatorColor: white,
              indicatorWeight: 3,
              labelStyle: AppTheme.normalText,
              tabs: [
                Tab(
                  text: "Lô nhập",
                ),
                Tab(
                  text: "Dược phẩm tồn",
                ),
              ],
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: loadingCall,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(
              color: white,
            ),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [importBatch, inventorBatch],
            ),
          ),
          // bottomNavigationBar: showFloatingButton != false ? button : null,
          // floatingActionButton: showFloatingButton != false ? button : null,
        ),
      ),
    );
  }
}
