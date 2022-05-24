// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:sertinary/user_authentication/login/login_screen.dart';
import '../../constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterVerifyScreen extends StatefulWidget {
  const RegisterVerifyScreen({Key? key}) : super(key: key);

  @override
  State<RegisterVerifyScreen> createState() => _RegisterVerifyScreenState();
}

class _RegisterVerifyScreenState extends State<RegisterVerifyScreen> {
  //Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Title Message
    final titleMessage = Padding(
      padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "\nJust one last step!",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 33,
                color: ColorConstants.mono05,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    //Account Creation Message
    final accountCreationMessage = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Your account has been created!",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 21,
              color: ColorConstants.accent50,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );

    //Instructions
    final instructions = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Please check your email\nfor a verification link\nand we'll get you started.",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 18,
              color: ColorConstants.mono95,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );

    //Back To Login Screen Button
    final toLoginScreenButton = Container(
      alignment: Alignment.centerRight,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.0, 0.5, 1.0],
              colors: [
                ColorConstants.accent30,
                ColorConstants.accent50,
                ColorConstants.accent30,
              ],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: MaterialButton(
            height: 54,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 15),
                Text(
                  "Login Screen",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.mono05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.double_arrow_rounded,
                  color: ColorConstants.mono05,
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: ColorConstants.mono05,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.0, 0.6],
            colors: [
              ColorConstants.accent50,
              ColorConstants.accent30,
            ],
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 140),
                  titleMessage,
                  const SizedBox(height: 36),
                  //Bottom Section
                  Container(
                    padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
                    height: 450.0,
                    margin: const EdgeInsets.only(top: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30.0)),
                      color: ColorConstants.mono05,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        accountCreationMessage,
                        const SizedBox(height: 39),
                        instructions,
                        const SizedBox(height: 43),
                        toLoginScreenButton,
                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
