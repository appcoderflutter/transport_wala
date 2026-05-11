import 'package:flutter/material.dart';

import '../../utility/const.dart';
import '../dimens.dart';
import '../mColours.dart';

class CustomTextTheme {
  const CustomTextTheme._();
  static TextStyle veryBig({Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: Dimens.veryBigTextSize,
      fontWeight: weight ?? FontWeight.w700,
      color: color ?? MColors.titleTextColor,
    );
  }

  static TextStyle big({Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: Dimens.bigTextSize,
      fontWeight: weight ?? FontWeight.w600,
      color: color ?? MColors.titleTextColor,
    );
  }

  static TextStyle title({Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: Dimens.titleTextSize,
      fontWeight: weight ?? FontWeight.w700,
      color: color ?? MColors.titleTextColor,
    );
  }

  static TextStyle desc({Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: Dimens.descTextSize,
      fontWeight: weight ?? FontWeight.w500,
      color: color ?? MColors.descTextColor,
    );
  }

  static TextStyle hint({Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: Dimens.hintTextSize,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? MColors.hintTextColor,
    );
  }

  static TextStyle meta({Color? color, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: Dimens.metaTextSize,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? MColors.descTextColor,
    );
  }

  static TextStyle small({Color? color,  double? fontSize,FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize:fontSize ?? Dimens.smallTextSize,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? MColors.descTextColor,
    );
  }

  static TextStyle regular(
      {Color? color, double? fontSize, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: fontSize ?? Dimens.descTextSize,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? MColors.descTextColor,
    );
  }

  static TextStyle medium({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: fontSize ?? Dimens.descTextSize,
      fontWeight: FontWeight.w500,
      color: color ?? MColors.descTextColor,
    );
  }

  static TextStyle semiBold({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: fontSize ?? Dimens.descTextSize,
      fontWeight: FontWeight.w600,
      color: color ?? MColors.descTextColor,
    );
  }

  static TextStyle bold({Color? color, double? fontSize, FontWeight? weight}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: fontSize ?? Dimens.descTextSize,
      fontWeight: weight ?? FontWeight.w700,
      color: color ?? MColors.titleTextColor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle extraBold({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: Consts.font,
      fontSize: fontSize ?? Dimens.bigTextSize,
      fontWeight: FontWeight.w800,
      color: color ?? MColors.titleTextColor,
    );
  }
}
