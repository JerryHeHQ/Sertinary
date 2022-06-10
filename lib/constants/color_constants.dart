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
  static Color mono00 = hexToColor('#000000');
  static Color mono05 = hexToColor('#0D0D0D');
  static Color mono10 = hexToColor('#1A1A1A');
  static Color mono15 = hexToColor('#262626');
  static Color mono20 = hexToColor('#333333');
  static Color mono25 = hexToColor('#404040');
  static Color mono30 = hexToColor('#4D4D4D');
  static Color mono35 = hexToColor('#595959');
  static Color mono40 = hexToColor('#666666');
  static Color mono45 = hexToColor('#737373');
  static Color mono50 = hexToColor('#808080');
  static Color mono55 = hexToColor('#8C8C8C');
  static Color mono60 = hexToColor('#999999');
  static Color mono65 = hexToColor('#a6a6a6');
  static Color mono70 = hexToColor('#B3B3B3');
  static Color mono75 = hexToColor('#BFBFBF');
  static Color mono80 = hexToColor('#CCCCCC');
  static Color mono85 = hexToColor('#D9D9D9');
  static Color mono90 = hexToColor('#E6E6E6');
  static Color mono95 = hexToColor('#F2F2F2');
  static Color monoAA = hexToColor('#FFFFFF');

  static Color accent10 = hexToColor('#332600'); //#332600
  static Color accent20 = hexToColor('#664C00'); //#664C00
  static Color accent30 = hexToColor('#997200'); //#997200 #E31CCC
  static Color accent40 = hexToColor('#CC9800'); //#CC9800
  static Color accent50 = hexToColor('#FFBE00'); //#FFBE00 #E31C79
  static Color accent60 = hexToColor('#FFCB33'); //#FFCB33
  static Color accent70 = hexToColor('#FFD866'); //#FFD866
  static Color accent80 = hexToColor('#FFE599'); //#FFE599
  static Color accent90 = hexToColor('#FFF2CC'); //#FFF2CC

  static Color fail = hexToColor('#B00020');
  static Color success = hexToColor('#00B020');
}
