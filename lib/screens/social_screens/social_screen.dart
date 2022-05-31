import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class SocialScreen extends StatefulWidget {
  final String text;

  buttonOneCalled() => _SocialScreenState().buttonOneCalled();
  buttonTwoCalled() => _SocialScreenState().buttonTwoCalled();
  buttonThreeCalled() => _SocialScreenState().buttonThreeCalled();

  const SocialScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
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
    log("Button One Method For SocialScreen Was Called");
  }

  void buttonTwoCalled() {
    log("Button Two Method For SocialScreen Was Called");
  }

  void buttonThreeCalled() {
    log("Button Three Method For SocialScreen Was Called");
  }
}
