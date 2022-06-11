import 'package:flutter/material.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';

class FormFieldConstants {
  static InputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorConstants.mono15, width: 1.8),
    borderRadius: BorderRadius.circular(6),
  );
  static InputBorder focusedBorder = GradientOutlineInputBorder(
    width: 2.1,
    gradient: GradientConstants.gradient1,
    borderRadius: BorderRadius.circular(6),
  );
  static InputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorConstants.fail, width: 2.1),
    borderRadius: BorderRadius.circular(6),
  );
  static InputBorder focusedErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorConstants.fail, width: 2.1),
    borderRadius: BorderRadius.circular(6),
  );
}
