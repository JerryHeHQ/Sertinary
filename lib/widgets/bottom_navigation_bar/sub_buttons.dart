import 'package:flutter/material.dart';
import 'package:sertinary/main.dart';
import 'dart:math' as math;
import 'package:sertinary/common_functions.dart';

class SubButtonLeft extends StatefulWidget {
  final void Function()? onPressed;

  const SubButtonLeft({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<SubButtonLeft> createState() => _SubButtonLeftState();
}

class _SubButtonLeftState extends State<SubButtonLeft> {
  CommonFunctions commonFunctions = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = widget.onPressed;
    return ValueListenableBuilder(
      valueListenable: subButtonsActive,
      builder: (context, value, widget) {
        return Positioned(
          bottom: 33 + math.sin(commonFunctions.degreesToRadians(30)) * 60,
          left: (MediaQuery.of(context).size.width / 2) -
              24 -
              math.cos(commonFunctions.degreesToRadians(30)) * 60,
          child: MaterialButton(
            enableFeedback: subButtonsActive.value,
            color: Colors.red,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            height: subButtonsActive.value ? 40 : 0,
            minWidth: subButtonsActive.value ? 40 : 0,
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}

class SubButtonCenter extends StatefulWidget {
  final void Function()? onPressed;

  const SubButtonCenter({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<SubButtonCenter> createState() => _SubButtonCenterState();
}

class _SubButtonCenterState extends State<SubButtonCenter> {
  CommonFunctions commonFunctions = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = widget.onPressed;
    return ValueListenableBuilder(
      valueListenable: subButtonsActive,
      builder: (context, value, widget) {
        return Positioned(
          bottom: 33 + math.sin(commonFunctions.degreesToRadians(90)) * 60,
          child: MaterialButton(
            enableFeedback: subButtonsActive.value,
            color: Colors.red,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            height: subButtonsActive.value ? 40 : 0,
            minWidth: subButtonsActive.value ? 40 : 0,
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}

class SubButtonRight extends StatefulWidget {
  final void Function()? onPressed;

  const SubButtonRight({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<SubButtonRight> createState() => _SubButtonRightState();
}

class _SubButtonRightState extends State<SubButtonRight> {
  CommonFunctions commonFunctions = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = widget.onPressed;
    return ValueListenableBuilder(
      valueListenable: subButtonsActive,
      builder: (context, value, widget) {
        return Positioned(
          bottom: 33 + math.sin(commonFunctions.degreesToRadians(30)) * 60,
          left: (MediaQuery.of(context).size.width / 2) -
              24 +
              math.cos(commonFunctions.degreesToRadians(30)) * 60,
          child: MaterialButton(
            enableFeedback: subButtonsActive.value,
            color: Colors.red,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            height: subButtonsActive.value ? 40 : 0,
            minWidth: subButtonsActive.value ? 40 : 0,
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
