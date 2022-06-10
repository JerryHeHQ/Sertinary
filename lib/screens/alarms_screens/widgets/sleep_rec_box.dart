import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/widgets/glass_box.dart';

class SleepRecommendedBox extends StatelessWidget {
  final int sleepTimeHour;
  final int sleepTimeMin;
  final int sleepCycles;
  final int hoursSlept;
  final int minsSlept;

  const SleepRecommendedBox({
    Key? key,
    required this.sleepTimeHour,
    required this.sleepTimeMin,
    required this.sleepCycles,
    required this.hoursSlept,
    required this.minsSlept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassBox(
      width: (MediaQuery.of(context).size.width - 4 * 12) / 3,
      height: 90,
      blur: 3,
      borderRadius: 18,
      borderColor: Colors.black.withOpacity(0.09),
      borderWidth: 1.5,
      gradientColors: [
        Colors.black.withOpacity(0.9),
        Colors.black.withOpacity(0.6),
      ],
      gradientBegin: Alignment.topLeft,
      gradientEnd: Alignment.bottomRight,
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            textAlign: TextAlign.center,
            TimeOfDay(
              hour: sleepTimeHour,
              minute: sleepTimeMin,
            ).format(context),
            style: GoogleFonts.montserrat(
              color: ColorConstants.accent50,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            '$sleepCycles Cycles',
            style: GoogleFonts.montserrat(
              color: ColorConstants.accent50,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            '$hoursSlept hr $minsSlept min',
            style: GoogleFonts.montserrat(
              color: ColorConstants.accent50,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
