import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/bottom_navigation_bar/sub_buttons.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
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
              'Social',
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
    AutoRouter.of(context).push(const SocialSavedRouter());
  }

  void centerSubButton() {
    AutoRouter.of(context).push(const SocialAddRouter());
  }

  void rightSubButton() {
    AutoRouter.of(context).push(const SocialProfileRouter());
  }
}
