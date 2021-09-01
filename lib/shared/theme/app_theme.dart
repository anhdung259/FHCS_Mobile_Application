import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF757575);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  // static const String fontRobo = 'Raleway';
  static const String fontRobo = 'Roboto';

  static const TextStyle nameApp = TextStyle(
    // h4 -> display1
    fontFamily: fontRobo,
    fontWeight: FontWeight.bold,
    fontSize: 25,
    letterSpacing: 0.1,

    color: white,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontRobo,
    fontWeight: FontWeight.w700,
    fontSize: 16.5,
    color: KPrimaryColor,
  );
  static const TextStyle titleInput = TextStyle(
    // h5 -> headline
    fontFamily: fontRobo,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.black,
  );
  static TextStyle titleList = TextStyle(
    // h6 -> title
    fontFamily: fontRobo,
    fontWeight: FontWeight.w600,
    fontSize: 19.5,
    letterSpacing: 0.15,
    color: darkText,
  );
  static const TextStyle titleAppbar = TextStyle(
    // h6 -> title
    fontSize: 19,
    letterSpacing: 0.15,
    color: white,
  );

  static TextStyle selectBox = TextStyle(
    // body1 -> body2
    fontFamily: fontRobo,

    fontSize: 17.5,
    letterSpacing: 0.2,
    color: darkText,
  );
  static TextStyle date = TextStyle(
    // body1 -> body2
    fontFamily: fontRobo,

    fontSize: 16,
    letterSpacing: 0.2,
    color: darkText.withOpacity(0.7),
  );
  static const TextStyle textBottomTab = TextStyle(
    // body2 -> body1
    fontFamily: fontRobo,
    fontWeight: FontWeight.w500,
    fontSize: 15.5,
    color: darkText,
  );
  static const TextStyle titleNoti = TextStyle(
    // body2 -> body1
    fontFamily: fontRobo,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle titleName = TextStyle(
    // body2 -> body1
    fontFamily: fontRobo,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: -0.05,
    color: KPrimaryColor,
  );
  static const TextStyle italic = TextStyle(
    // body2 -> body1
    fontFamily: fontRobo,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );
  static const TextStyle infoPrescription = TextStyle(
    // body1 -> body2
    fontFamily: fontRobo,

    fontSize: 16.5,
    letterSpacing: 0.1,
    color: darkText,
  );
  static TextStyle seemore = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontWeight: FontWeight.bold,
    fontSize: 17,
    letterSpacing: 0.18,
    color: dark_grey.withOpacity(0.5), // was lightText
  );
  static const TextStyle titleDetail = TextStyle(
      // Caption -> caption
      fontFamily: fontRobo,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      letterSpacing: 0.15,
      color: darkText // was lightText
      );
  static const TextStyle captitleDetail = TextStyle(
      // Caption -> caption
      fontFamily: fontRobo,
      fontWeight: FontWeight.w600,
      fontSize: 15,
      letterSpacing: 0.15,
      color: darkText // was lightText
      );
  static TextStyle highlight = TextStyle(
      // Caption -> caption
      fontFamily: fontRobo,
      fontWeight: FontWeight.w600,
      fontSize: 16.5,
      letterSpacing: 0.15,
      color: dark_grey.withOpacity(0.8) // was lightText
      );
  static const TextStyle titleNotifi = TextStyle(
      // Caption -> caption
      fontFamily: fontRobo,
      fontWeight: FontWeight.w600,
      fontSize: 17.5,
      letterSpacing: 0.15,
      color: dark_grey // was lightText
      );
  static const TextStyle login = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontWeight: FontWeight.w500,
    fontSize: 30,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle notify = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.1,
    color: darkText, // was lightText
  );

  static const TextStyle normalText = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontWeight: FontWeight.w500,
    fontSize: 16.5,
    letterSpacing: 0.1,
    color: darkText, // was lightText
  );
  static const TextStyle message = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontWeight: FontWeight.w500,
    fontSize: 14.5,
    letterSpacing: 0.1,
    color: darkText, // was lightText
  );
  static TextStyle blurred = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontSize: 16,
    letterSpacing: 0.1,
    color: grey, // was lightText
  );
  static TextStyle primaryColor = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    letterSpacing: 0.1,
    color: KPrimaryColor.withOpacity(0.8), // was lightText
  );
  static const TextStyle titleTable = TextStyle(
    // Caption -> caption
    fontFamily: fontRobo,
    fontWeight: FontWeight.w500,
    fontSize: 22,
    letterSpacing: 0.15,
    color: darkText, // was lightText
  );
}
