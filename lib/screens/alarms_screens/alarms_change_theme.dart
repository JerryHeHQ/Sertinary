import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmsChangeTheme extends StatefulWidget {
  const AlarmsChangeTheme({Key? key}) : super(key: key);

  @override
  State<AlarmsChangeTheme> createState() => _AlarmsChangeThemeState();
}

class _AlarmsChangeThemeState extends State<AlarmsChangeTheme> {
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
            'AlarmsChangeTheme',
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
