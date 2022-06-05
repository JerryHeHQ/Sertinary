import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackerChangeDate extends StatefulWidget {
  const TrackerChangeDate({Key? key}) : super(key: key);

  @override
  State<TrackerChangeDate> createState() => _TrackerChangeDateState();
}

class _TrackerChangeDateState extends State<TrackerChangeDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        foregroundColor: ColorConstants.monoAA,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: ColorConstants.mono10,
        child: Center(
          child: Text(
            'TrackerChangeDate',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: ColorConstants.mono90,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
