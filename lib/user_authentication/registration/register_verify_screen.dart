import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';

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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorConstants.mono10,
          behavior: SnackBarBehavior.floating,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: ColorConstants.success,
              ),
              Text(
                ' Account Creation Success!',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: ColorConstants.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //Title Message
    final titleMessage = Padding(
      padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '\nJust one last step!',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 30,
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
          'Your account has been created!',
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
          'Please check your email\nfor a verification link\nand we\'ll get you started.',
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
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: BoxDecoration(
            gradient: GradientConstants.gradient1,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.mono00,
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: MaterialButton(
            height: 54,
            onPressed: () {
              AutoRouter.of(context).replaceAll(
                [
                  const LoginRoute(),
                ],
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 15),
                Text(
                  'Login Screen',
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        foregroundColor: ColorConstants.mono00,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: GradientConstants.gradient1,
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
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      color: ColorConstants.mono10,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.mono00,
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: const Offset(1.5, -1.5),
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
