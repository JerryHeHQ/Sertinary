import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class PlannerScreen extends StatefulWidget {
  final String text;

  buttonOneCalled() => _PlannerScreenState().buttonOneCalled();
  buttonTwoCalled() => _PlannerScreenState().buttonTwoCalled();
  buttonThreeCalled() => _PlannerScreenState().buttonThreeCalled();

  const PlannerScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  @override
  Widget build(BuildContext context) {
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
    log("Button One Method For PlannerScreen Was Called");
  }

  void buttonTwoCalled() {
    log("Button Two Method For PlannerScreen Was Called");
  }

  void buttonThreeCalled() {
    log("Button Three Method For PlannerScreen Was Called");
  }
}
