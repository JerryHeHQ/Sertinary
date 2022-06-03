import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class TrackerScreen extends StatefulWidget {
  final String text;

  buttonOneCalled() => _TrackerScreenState().buttonOneCalled();
  buttonTwoCalled() => _TrackerScreenState().buttonTwoCalled();
  buttonThreeCalled() => _TrackerScreenState().buttonThreeCalled();

  const TrackerScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  void buttonOneCalled() {
    log("Button One Method For TrackerScreen Was Called");
  }

  void buttonTwoCalled() {
    log("Button Two Method For TrackerScreen Was Called");
  }

  void buttonThreeCalled() {
    log("Button Three Method For TrackerScreen Was Called");
  }
}
