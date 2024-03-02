import 'package:flutter/material.dart';
import 'package:dial/core/utils/size_utils.dart';

import 'color_constant.dart';

abstract class DL {
  /// Default font family
  static const String defaultFontOfApp = 'Poppins';
  static const String _defaultFontFamily = defaultFontOfApp;
  static const FontWeight _defaultFontWeight = FontWeight.w400;

  static TextStyle style(int size,
      {Color? fontColor, String? fontFamily, FontWeight? fontWeight}) {
    const defaultFontColor = ColorConstant.primaryBlack;
    switch (size) {
      case 6:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(7),
            color: fontColor ?? defaultFontColor);

      case 10:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(8),
            color: fontColor ?? defaultFontColor);

      case 12:
        return TextStyle(
            fontSize: getFontSize(9), //7.5.sp
            fontWeight: fontWeight ?? _defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 14:
        return TextStyle(
            fontSize: getFontSize(12), //7.5.sp
            fontWeight: fontWeight ?? _defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 15:
        return TextStyle(
            fontSize: getFontSize(13), //7.5.sp
            fontWeight: fontWeight ?? _defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 16:
        return TextStyle(
            fontSize: getFontSize(14), //7.5.sp
            fontWeight: fontWeight ?? _defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 13:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(11),
            color: fontColor ?? defaultFontColor);

      case 14:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(11),
            color: fontColor ?? defaultFontColor);

      case 15:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(13),
            color: fontColor ?? defaultFontColor);

      case 16:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(12),
            color: fontColor ?? defaultFontColor);

      case 17:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(15),
            color: fontColor ?? defaultFontColor);

      case 18:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(16),
            color: fontColor ?? defaultFontColor);

      case 19:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(17),
            color: fontColor ?? defaultFontColor);

      case 20:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(18),
            color: fontColor ?? defaultFontColor);

      case 21:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(19),
            color: fontColor ?? defaultFontColor);

      case 24:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(22),
            color: fontColor ?? defaultFontColor);

      case 25:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(23),
            color: fontColor ?? defaultFontColor);

      case 26:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(24),
            color: fontColor ?? defaultFontColor);

      case 27:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(25),
            color: fontColor ?? defaultFontColor);

      case 28:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(26),
            color: fontColor ?? defaultFontColor);

      case 30:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(28),
            color: fontColor ?? defaultFontColor);

      case 34:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(32),
            color: fontColor ?? defaultFontColor);

      case 36:
        return TextStyle(
            fontSize: getFontSize(36), //8.sp,
            fontWeight: fontWeight ?? _defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 40:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(38),
            color: fontColor ?? defaultFontColor);
      case 44:
        return TextStyle(
            fontWeight: fontWeight ?? _defaultFontWeight,
            fontSize: getFontSize(42),
            color: fontColor ?? defaultFontColor);

      default:
        return TextStyle(
            fontSize: getFontSize(10.5), //12,
            fontWeight: fontWeight ?? _defaultFontWeight,
            color: fontColor ?? defaultFontColor);
    }
  }

  static TextStyle styleDL(
      {double? fontSize,
      Color? fontColor,
      String? fontFamily,
      FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: getFontSize(fontSize ?? 12),
        fontWeight: fontWeight ?? _defaultFontWeight,
        color: fontColor ?? ColorConstant.primaryBlack);
  }
}
