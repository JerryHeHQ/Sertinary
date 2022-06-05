import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialAdd extends StatefulWidget {
  const SocialAdd({Key? key}) : super(key: key);

  @override
  State<SocialAdd> createState() => _SocialAddState();
}

class _SocialAddState extends State<SocialAdd> {
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
            'SocialAdd',
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
