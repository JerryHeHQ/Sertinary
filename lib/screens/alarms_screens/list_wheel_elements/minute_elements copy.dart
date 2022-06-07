import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';

class MinuteElements extends StatelessWidget {
  final int mins;

  const MinuteElements({super.key, required this.mins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Text(
          (mins < 10) ? '0$mins' : mins.toString(),
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: ColorConstants.monoAA,
            ),
          ),
        ),
      ),
    );
  }
}
