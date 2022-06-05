import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';

class SocialProfile extends StatefulWidget {
  const SocialProfile({Key? key}) : super(key: key);

  @override
  State<SocialProfile> createState() => _SocialProfileState();
}

class _SocialProfileState extends State<SocialProfile> {
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
            'SocialProfile',
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
