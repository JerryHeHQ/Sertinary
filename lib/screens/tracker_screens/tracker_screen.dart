import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/sub_buttons/sub_buttons.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
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
              'Tracker',
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
        SubButtonLeft(onPressed: () => leftSubButton()),
        SubButtonCenter(onPressed: () => centerSubButton()),
        SubButtonRight(onPressed: () => rightSubButton()),
      ],
    );
  }

  void leftSubButton() {
    AutoRouter.of(context).push(const TrackerOverviewRouter());
  }

  void centerSubButton() {
    AutoRouter.of(context).push(const TrackerAddRouter());
  }

  void rightSubButton() {
    AutoRouter.of(context).push(const TrackerChangeDateRouter());
  }
}
