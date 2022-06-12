import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';

class GradientConstants {
  static Gradient gradient1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorConstants.accent50,
      ColorConstants.accent30,
    ],
  );

  static Gradient gradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorConstants.mono30,
      ColorConstants.mono15,
    ],
  );

  static Gradient gradient3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorConstants.mono00,
      ColorConstants.mono15,
    ],
  );

  static Gradient gradient4 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorConstants.mono15,
      ColorConstants.mono00,
    ],
  );

  static Gradient gradient5 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorConstants.mono30,
      ColorConstants.mono30,
    ],
  );

  static Gradient gradient6 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorConstants.fail,
      ColorConstants.fail,
    ],
  );
}
