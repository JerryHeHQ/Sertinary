import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';

class DOTWButton extends StatelessWidget {
  final bool on;
  final String day;
  final void Function()? onTap;

  const DOTWButton({
    Key? key,
    required this.on,
    required this.day,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enabledGradient = GradientConstants.gradient1;

    final disabledGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorConstants.mono10,
        ColorConstants.mono10,
      ],
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        height: 39,
        width: 42,
        decoration: BoxDecoration(
          gradient: on ? enabledGradient : disabledGradient,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          day,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: ColorConstants.monoAA,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
