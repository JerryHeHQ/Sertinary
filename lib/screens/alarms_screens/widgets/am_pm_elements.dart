import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';

class AMPMElements extends StatelessWidget {
  final int index;

  const AMPMElements({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Text(
          (index < 1) ? 'AM' : 'PM',
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
