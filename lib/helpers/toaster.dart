// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../resources/dimens.dart';
// import '../resources/mColours.dart';
//
// enum ToastType { short, long, shortToLong, longToLong, custom }
//
// class AppToast {
//   // Default style
//   static final Color _bgColor = MColors.colorPrimary;
//   static final Color _textColor = MColors.white;
//   static final double _fontSize = Dimens.descTextSize;
//
//   /// SHORT
//   static void short(String message) {
//     _show(message, toastLength: Toast.LENGTH_SHORT, second: 2);
//   }
//
//   /// LONG
//   static void long(String message) {
//     _show(message, toastLength: Toast.LENGTH_LONG, second: 10);
//   }
//
//   /// SHORT ➜ LONG (shows twice)
//   static Future<void> shortToLong(String message) async {
//     short(message);
//     await Future.delayed(const Duration(seconds: 2));
//     long(message);
//   }
//
//   /// LONG ➜ LONG (shows twice)
//   static Future<void> longToLong(String message) async {
//     long(message);
//     await Future.delayed(const Duration(seconds: 4));
//     long(message);
//   }
//
//   /// CUSTOM (only message + seconds)
//   static void custom(String message, {int seconds = 6}) {
//     _show(message, toastLength: Toast.LENGTH_LONG, second: seconds);
//   }
//
//   /// Internal method
//   static void _show(
//     String message, {
//     required Toast toastLength,
//     required int second,
//   }) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: toastLength,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: second,
//       backgroundColor: _bgColor,
//       textColor: _textColor,
//       fontSize: _fontSize,
//     );
//   }
// }
//
// // AppToast.short("Login success");
//
// // AppToast.long("Please wait...");
//
// // AppToast.shortToLong("Processing request");
//
// // AppToast.longToLong("Uploading file");
//
// // AppToast.custom("Saved successfully", seconds: 5);

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/dimens.dart';
import '../resources/mColours.dart';

enum ToastType {
  short,
  long,
  shortToLong,
  longToLong,
  custom,
}

class AppToast {

  /// =========================
  /// APP STYLE
  /// =========================

  static final Color _bgColor = const Color(0xFF143070);

  static final Color _textColor = MColors.white;

  static final double _fontSize = Dimens.descTextSize;

  /// =========================
  /// SHORT
  /// =========================

  static void short(String message) {

    _show(
      message,
      toastLength: Toast.LENGTH_SHORT,
      second: 2,
    );
  }

  /// =========================
  /// LONG
  /// =========================

  static void long(String message) {

    _show(
      message,
      toastLength: Toast.LENGTH_LONG,
      second: 6,
    );
  }

  /// =========================
  /// SHORT ➜ LONG
  /// =========================

  static Future<void> shortToLong(String message) async {

    short(message);

    await Future.delayed(
      const Duration(seconds: 2),
    );

    long(message);
  }

  /// =========================
  /// LONG ➜ LONG
  /// =========================

  static Future<void> longToLong(String message) async {

    long(message);

    await Future.delayed(
      const Duration(seconds: 4),
    );

    long(message);
  }

  /// =========================
  /// CUSTOM
  /// =========================

  static void custom(
      String message, {
        int seconds = 5,
      }) {

    _show(
      message,
      toastLength: Toast.LENGTH_LONG,
      second: seconds,
    );
  }

  /// =========================
  /// INTERNAL
  /// =========================

  static void _show(
      String message, {
        required Toast toastLength,
        required int second,
      }) {

    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: "  $message  ",

      toastLength: toastLength,

      gravity: ToastGravity.BOTTOM,

      timeInSecForIosWeb: second,

      backgroundColor: _bgColor,

      textColor: _textColor,

      fontSize: _fontSize,

      webBgColor: "linear-gradient(to right, #2F66F6, #001A9F)",

      webPosition: "center",

      webShowClose: false,
    );
  }
}
