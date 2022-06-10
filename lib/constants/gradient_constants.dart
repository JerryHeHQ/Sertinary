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
}
