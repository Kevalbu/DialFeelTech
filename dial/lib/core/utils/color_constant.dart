import 'package:flutter/material.dart';

class ColorConstant {
  static const Color greyColor72 = Color(0xFFC7C5C5);

  static const Color greyColorB3 = Color(0xFFE8E5E5);
  // static Color black900Af = fromHex('#af000000');
  static const Color transparent = Colors.transparent;
  static const Color primaryWhite = Color(0xFFffffff);
  static const Color primaryBlue = Color(0xFF113B8D);
  static Color primaryWhiteBlue = Color(0xFF113B8D).withOpacity(0.3);
  static const Color primaryBlack = Color(0xFF000000);
  static const Color greyText = Color(0xFF747474);
  static const Color greyColord3 = Color(0xFFD3D3D3);
  static const Color greyBack = Color(0xFFF8FAFC);
  static const Color green = Color(0xFF52C952);
  static const Color yellow = Color(0xFFFECB07);
  static const Color red = Color(0xFFDE3A3A);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
