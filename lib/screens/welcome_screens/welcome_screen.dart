import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorConstants.mono10,
        image: const DecorationImage(
          image: AssetImage('assets/images/Welcome.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
