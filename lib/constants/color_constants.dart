import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color themeHighlightColor = hexToColor('#FFBE00');
  static Color themeMidtoneColor = hexToColor('#D9A300');
  static Color themeShadowColor = hexToColor('#B38600');

  static Color baseHighlightColor = hexToColor('#1A1A1A');
  static Color baseMidtoneColor = hexToColor('#333333');
  static Color baseShadowColor = hexToColor('#4D4D4D');

  static Color fontHighlight = hexToColor('#FFFFFF');
  static Color fontShadow = hexToColor('#000000');
}
