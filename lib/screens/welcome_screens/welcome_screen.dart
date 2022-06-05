import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
          'Welcome',
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
}
