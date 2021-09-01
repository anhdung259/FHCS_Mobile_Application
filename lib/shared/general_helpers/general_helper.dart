import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:fhcs_mobile_application/controller/login/login_controller.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/login_repository.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class GeneralHelper {
  static ApiProvider apiProvider = new ApiProvider();
  static CustomProgressDialog progressDialog(BuildContext context) {
    CustomProgressDialog pd = CustomProgressDialog(context);
    pd.setLoadingWidget(CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(KPrimaryColor)));
    return pd;
  }

  static checkTokenExpiration() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    return JwtDecoder.isExpired(token);
  }

  static showAccountDeActive() async {
    var active = await GeneralHelper.getValueSharedPreferences("active");
    print(active);
    if (active == true) {
      GeneralHelper.saveToSharedPreferences("active", false);
      LoginController lc = Get.put(LoginController(
          loginRepository: LoginRepository(apiClient: ApiProvider())));
      ProgressDialog pd = ProgressDialog(
        Get.context,
        message: Text("Tài khoản đã bị vô hiệu hóa."),
        dialogStyle: DialogStyle(titlePadding: EdgeInsets.zero),
        title: Container(
          height: getProportionateScreenHeight(35),
          color: KPrimaryColor,
          child: Center(
            child: Text(
              "Thông báo",
              style: TextStyle(color: white),
            ),
          ),
        ),
        dismissable: false,
      );
      pd.show();
      Future.delayed(Duration(seconds: 3)).then((value) {
        pd.dismiss();
        lc.signOut();
      });
    }
  }

  static showTokenExpirationLoginAgain() async {
    LoginController lc = Get.put(LoginController(
        loginRepository: LoginRepository(apiClient: ApiProvider())));
    ProgressDialog pd = ProgressDialog(
      Get.context,
      message: Text(
          "Tài khoản đã hết thời gian đăng nhập.\n Vui lòng đăng nhập lại."),
      dialogStyle: DialogStyle(titlePadding: EdgeInsets.zero),
      title: Container(
        height: getProportionateScreenHeight(35),
        color: KPrimaryColor,
        child: Center(
          child: Text(
            "Thông báo",
            style: TextStyle(color: white),
          ),
        ),
      ),
      dismissable: false,
    );
    bool isTokenExpired;
    await checkTokenExpiration().then((value) => isTokenExpired = value);
    print(isTokenExpired);
    if (isTokenExpired != false) {
      pd.show();
      Future.delayed(Duration(seconds: 3)).then((value) {
        pd.dismiss();
        lc.signOut();
      });
    }
  }

  static refreshTokenApi() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    bool isTokenExpired = JwtDecoder.isExpired(token);
    DateTime timeNow = DateTime.now();
    DateTime expirationDate = JwtDecoder.getExpirationDate(token);
    final timeBeforeExpiration = expirationDate.difference(timeNow).inMinutes;
    print(timeBeforeExpiration);
    if (isTokenExpired != false && timeBeforeExpiration <= 15) {
      print("time expriration :" + timeBeforeExpiration.toString());
      refreshNewToken();
    }
  }

  static void refreshNewToken() async {
    var result = await apiProvider.refreshToken();
    if (result.statusCode == 200) {
      await saveToSharedPreferences("token", result.data.token);
    } else {
      showMessage(msg: result.message);
    }
  }

  static var vndFormat =
      new NumberFormat.currency(locale: "vi_VN", symbol: "₫");
  static delayTimeAndCallback(
      int milliseconds, void Function() callback) async {
    var duration = new Duration(milliseconds: milliseconds);
    return new Timer(duration, callback);
  }

  static bool checkCurrentPeriodic(int monthPeriodic, int yearPeriodic) {
    DateTime now = new DateTime.now();
    var currentMonth = now.month;
    var currentYear = now.year;
    if (currentMonth == monthPeriodic && currentYear == yearPeriodic) {
      return true;
    } else {
      return false;
    }
  }

  static void updateSearchMap(
      {String fieldSearch,
      String valueSearch,
      String compare,
      Map<String, ValueCompare> searchMap}) {
    searchMap.update(fieldSearch,
        (value) => ValueCompare(value: valueSearch, compare: compare),
        ifAbsent: () => ValueCompare(value: valueSearch, compare: compare));
  }

  static void paging({
    RxBool isMoreDataAvailable,
    Future<dynamic> searchFuntion(SearchRequest request),
    Rx<Info> info,
    RxList<dynamic> listPagination,
    Future<void> Function() checkFunction,
    int limit,
    List<String> groupBys,
    List<String> includes,
    List<String> allergyIds,
    List<String> diagnosticIds,
    Map<String, ValueCompare> searchValue,
    String selectFields,
    String sortField,
    int sortOrder,
  }) async {
    info.value.page++;
    searchFuntion(SearchRequest(
            page: info.value.page,
            limit: limit,
            groupBys: groupBys,
            includes: includes,
            searchValue: searchValue,
            selectFields: selectFields,
            sortField: sortField,
            sortOrder: sortOrder,
            allergyIds: allergyIds,
            diagnosticIds: diagnosticIds))
        .then((resp) async {
      if (resp.data.data.length > 0) {
        isMoreDataAvailable(true);
        listPagination.addAll(resp.data.data);
        if (checkFunction != null) {
          await checkFunction();
        }
      } else {
        isMoreDataAvailable(false);
        showMessageToast(msg: "Đã hiển thị tất cả");
      }
    }, onError: (err) {
      isMoreDataAvailable(false);
      GeneralHelper.showMessage(msg: err.toString());
    });
  }

  static showConfirmBackScreenInput({Function function}) {
    showConfirm(
      title: "Chắc chắn rời khỏi trang này?",
      msg: "Thông tin vừa nhập sẽ không được lưu lại.",
      pressCancel: () {},
      textCancel: "Ở Lại",
      textOk: "Rời khỏi",
      pressOk: () {
        function?.call();
        Get.back();
      },
    );
    return Future.value(false);
  }

  static void showFilterDialog({@required Widget filter}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      backgroundColor: Colors.white,
      context: Get.context,
      isScrollControlled: true,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          filter,
          Padding(
            padding: EdgeInsets.only(
                bottom: Get.context.mediaQueryViewInsets.bottom),
          ),
        ],
      ),
    );
  }

  static void showMessageToast({@required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
      textColor: darkText,
      timeInSecForIosWeb: 1,
    );
  }

  static void showSuccessToast({@required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      fontSize: 16,
      textColor: white,
      backgroundColor: Colors.green,
      timeInSecForIosWeb: 1,
    );
  }

  static void showMessage({@required String msg, Function press}) async {
    if (msg != "AccountId is not exist or not active in system!") {
      NDialog(
          dialogStyle: DialogStyle(titlePadding: EdgeInsets.zero),
          title: Container(
            height: getProportionateScreenHeight(40),
            color: KPrimaryColor,
            child: Center(
              child: Text(
                "Thông báo",
                style: TextStyle(color: white),
              ),
            ),
          ),
          content: Text(
            msg,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(KPrimaryColor),
                ),
                child: Text("Đóng", style: TextStyle(color: white)),
                onPressed: () {
                  press?.call();
                  Get.back();
                },
              ),
            )
          ]).show(Get.context);
    }
  }

  static void showConfirm(
      {@required String title,
      @required String msg,
      @required String textOk,
      String textCancel,
      @required Function pressOk,
      Function pressCancel}) async {
    NDialog(
      title:
          Text(title, style: AppTheme.titleDetail, textAlign: TextAlign.center),
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SizedBox(
          width: getProportionateScreenWidth(30),
        ),
        TextButton(
          child: Text(textCancel.toUpperCase(),
              style:
                  TextStyle(color: KPrimaryColor, fontWeight: FontWeight.w600)),
          onPressed: () {
            Get.back();
            pressCancel?.call();
          },
        ),
        TextButton(
          child: Text(textOk.toUpperCase(),
              style:
                  TextStyle(color: KPrimaryColor, fontWeight: FontWeight.w600)),
          onPressed: () {
            Get.back();
            pressOk();
          },
        ),
      ],
    ).show(
      Get.context,
    );
  }

  static void showInput(
      {@required String title,
      @required Function pressOk,
      @required TextEditingController controller,
      @required String hintText}) async {
    NDialog(
      dialogStyle: DialogStyle(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.titleDetail,
          ),
          SizedBox(
            width: getProportionateScreenWidth(30),
          ),
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.close))
        ],
      ),
      content: RoundedInputField(
        sizeHeight: getProportionateScreenHeight(70),
        controller: controller,
        hintText: hintText,
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(KPrimaryColor),
          ),
          child: Text("Thêm",
              style: TextStyle(color: white, fontWeight: FontWeight.w600)),
          onPressed: () {
            // Get.back();
            pressOk();
          },
        ),
      ],
    ).show(Get.context);
  }

  static void showInsertNew(
      {@required String title,
      @required Function pressOk,
      Function clear,
      Widget content}) async {
    NDialog(
      dialogStyle: DialogStyle(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.titleDetail,
          ),
          SizedBox(
            width: getProportionateScreenWidth(30),
          ),
          InkWell(
              onTap: () {
                clear?.call();
                Get.back();
              },
              child: Icon(Icons.close))
        ],
      ),
      content: content,
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(KPrimaryColor),
          ),
          child: Text("Thêm",
              style: TextStyle(color: white, fontWeight: FontWeight.w600)),
          onPressed: () {
            pressOk?.call();
          },
        ),
      ],
    ).show(Get.context, dismissable: false);
  }

  static void showInputEliminate({
    @required String title,
    @required Function pressOk,
    @required TextEditingController controllerQuantity,
    @required TextEditingController controllerReason,
  }) async {
    NDialog(
      dialogStyle: DialogStyle(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.titleDetail,
          ),
          SizedBox(
            width: getProportionateScreenWidth(30),
          ),
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.close))
        ],
      ),
      content: Container(
        height: 250,
        child: Column(
          children: [
            BoxInput(
              title: "Số lượng hủy:",
              child: RoundedInputField(
                controller: controllerQuantity,
                isNumber: true,
                textInputFormat: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                ],
              ),
            ),
            BoxInput(
              title: "Lý do hủy:",
              child: RoundedInputField(
                controller: controllerReason,
                line: 2,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(KPrimaryColor),
          ),
          child: Text("Xác nhận",
              style: TextStyle(color: white, fontWeight: FontWeight.w600)),
          onPressed: () {
            // Get.back();
            pressOk();
          },
        ),
      ],
    ).show(Get.context, dismissable: false);
  }

  static formatCurrencyText(String currency) {
    return vndFormat.format(double.parse(currency));
  }

  static String formatNumber(String s) =>
      NumberFormat.decimalPattern("vi").format(int.parse(s));

  static formatDateText(String date, bool display) {
    DateTime dateTime = DateTime.parse(date);
    if (display == true) {
      return formatDate(dateTime, [dd, '/', mm, '/', yyyy]);
    }
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
  }

  static subtractDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate = new DateTime(dateTime.year - 1, dateTime.month, dateTime.day);
    DateTime now = DateTime.now();
    if (newDate.isBefore(now)) {
      return formatDate(now, [yyyy, '-', mm, '-', dd]);
    }
    print(formatDate(newDate, [yyyy, '-', mm, '-', dd]));
    return formatDate(newDate, [yyyy, '-', mm, '-', dd]);
  }

  static formatFullDateText(String date) {
    DateTime dateTime = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    return formatDate(dateTime, [dd, '/', mm, '/', yyyy, " ", HH, ":", nn]);
  }

  static String checkDisplayIcon(String action) {
    switch (action) {
      case "Remove":
        return REMOVE;
        break;
      case "InsertNew":
        return CREATE_NEW;
        break;
      case "Update":
        return UPDATE;
        break;
      case "Show":
        return WARNING;
        break;
      case "UpdateApp":
        return UPDATE_APP;
        break;

      default:
        return CREATE_NEW;
    }
  }

  static Color checkDisplayColor(int status) {
    switch (status) {
      case 1:
        return success;
        break;
      case 2:
        return current;
        break;
      case 3:
        return error;
        break;
      case 4:
        return darkText;
        break;
      case 5:
        return waring;
        break;

      default:
        return success;
    }
  }

  static navigateToScreen(Widget screen, bool removedCurrentScreen) async {
    if (removedCurrentScreen) {
      Get.off(screen);
    } else {
      Get.to(screen);
    }
  }

  static saveToSharedPreferences(String key, dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data is String) {
      prefs.setString(key, data);
    } else if (data is int) {
      prefs.setInt(key, data);
    } else if (data is double) {
      prefs.setDouble(key, data);
    } else if (data is bool) {
      prefs.setBool(key, data);
    } else if (data is List<String>) {
      prefs.setStringList(key, data);
    }
  }

  static dynamic getValueSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static clearLocalStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.remove(key);
  }
}
