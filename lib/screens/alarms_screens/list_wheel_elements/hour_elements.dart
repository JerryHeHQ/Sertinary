import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';

class HourElements extends StatelessWidget {
  final int hours;

  const HourElements({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: Text(
          (hours < 10) ? '0$hours' : hours.toString(),
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
