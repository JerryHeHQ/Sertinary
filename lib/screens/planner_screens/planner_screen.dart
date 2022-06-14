import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({Key? key}) : super(key: key);

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          color: ColorConstants.mono10,
          child: Center(
            child: Text(
              'Planner',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: ColorConstants.mono90,
                  fontSize: 60,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        // SubButtonLeft(onPressed: () => leftSubButton()),
        // SubButtonCenter(onPressed: () => centerSubButton()),
        // SubButtonRight(onPressed: () => rightSubButton()),
      ],
    );
  }

  // void leftSubButton() {
  //   AutoRouter.of(context).push(const PlannerWorkRythmnRouter());
  // }

  // void centerSubButton() {
  //   AutoRouter.of(context).push(const PlannerAddRouter());
  // }

  // void rightSubButton() {
  //   AutoRouter.of(context).push(const PlannerChangeDateRouter());
  // }
}
