import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  final String text;

  buttonOneCalled() => _WelcomeScreenState().buttonOneCalled();
  buttonTwoCalled() => _WelcomeScreenState().buttonTwoCalled();
  buttonThreeCalled() => _WelcomeScreenState().buttonThreeCalled();

  const WelcomeScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with AutomaticKeepAliveClientMixin<WelcomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    log("Button One Method For WelcomeScreen Was Called");
  }

  void buttonTwoCalled() {
    log("Button Two Method For WelcomeScreen Was Called");
  }

  void buttonThreeCalled() {
    log("Button Three Method For WelcomeScreen Was Called");
  }
}
