import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class AlarmsScreen extends StatefulWidget {
  final String text;

  buttonOneCalled() => _AlarmsScreenState().buttonOneCalled();
  buttonTwoCalled() => _AlarmsScreenState().buttonTwoCalled();
  buttonThreeCalled() => _AlarmsScreenState().buttonThreeCalled();

  const AlarmsScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen>
    with AutomaticKeepAliveClientMixin<AlarmsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: ColorConstants.mono10,
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: ColorConstants.mono90,
                fontSize: 60,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buttonOneCalled() {
    log("Button One Method For AlarmsScreen Was Called");
  }

  void buttonTwoCalled() {
    log("Button Two Method For AlarmsScreen Was Called");
  }

  void buttonThreeCalled() {
    log("Button Three Method For AlarmsScreen Was Called");
  }
}
