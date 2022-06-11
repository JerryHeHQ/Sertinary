import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sertinary/common_functions.dart';
import 'package:sertinary/main.dart';

class SubButtonLeft extends StatefulWidget {
  final void Function()? onPressed;

  const SubButtonLeft({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<SubButtonLeft> createState() => _SubButtonLeftState();
}

class _SubButtonLeftState extends State<SubButtonLeft> {
  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = widget.onPressed;
    return ValueListenableBuilder(
      valueListenable: subButtonsActive,
      builder: (context, value, widget) {
        return Positioned(
          bottom: 33 + math.sin(CommonFunctions.degreesToRadians(30)) * 60,
          left: (MediaQuery.of(context).size.width / 2) -
              24 -
              math.cos(CommonFunctions.degreesToRadians(30)) * 60,
          child: MaterialButton(
            enableFeedback: subButtonsActive.value,
            color: Colors.transparent,
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
  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = widget.onPressed;
    return ValueListenableBuilder(
      valueListenable: subButtonsActive,
      builder: (context, value, widget) {
        return Positioned(
          bottom: 33 + math.sin(CommonFunctions.degreesToRadians(90)) * 60,
          child: MaterialButton(
            enableFeedback: subButtonsActive.value,
            color: Colors.transparent,
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
  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = widget.onPressed;
    return ValueListenableBuilder(
      valueListenable: subButtonsActive,
      builder: (context, value, widget) {
        return Positioned(
          bottom: 33 + math.sin(CommonFunctions.degreesToRadians(30)) * 60,
          left: (MediaQuery.of(context).size.width / 2) -
              24 +
              math.cos(CommonFunctions.degreesToRadians(30)) * 60,
          child: MaterialButton(
            enableFeedback: subButtonsActive.value,
            color: Colors.transparent,
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
