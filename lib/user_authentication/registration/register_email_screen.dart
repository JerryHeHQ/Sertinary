import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class RegisterEmailScreen extends StatefulWidget {
  final String username;
  const RegisterEmailScreen({Key? key, required this.username})
      : super(key: key);

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  //Firebase
  final _auth = FirebaseAuth.instance;

  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final TextEditingController _emailController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _emailLabelColor = ColorConstants.mono75;

  //Changes NextButton State Based On TextFormField Inputs
  bool _enableNextButton = false;

  @override
  Widget build(BuildContext context) {
    //Title Message
    final titleMessage = Padding(
      padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nice to meet you\n${widget.username}!',
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

    //Instructions
    final instructions = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enter your email to start\ncreating your account.',
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

    //Email Form Field
    final emailField = Focus(
      onFocusChange: (hasFocus) {
        setState(() => _emailLabelColor =
            hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
      },
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ('Please Enter Your Email');
          }
          //RegExp To Check If Email Is Valid
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return ('Please Enter A Valid Email');
          }
          return null;
        },
        onSaved: (value) {
          _emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        cursorColor: ColorConstants.accent50,
        cursorHeight: 18,
        style: TextStyle(
          fontSize: 16,
          color: ColorConstants.mono95,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.mono10,
          filled: true,
          prefixIcon: GradientWidget(
            gradient: GradientConstants.gradient1,
            child: Icon(
              Icons.mail,
              color: ColorConstants.accent50,
            ),
          ),
          suffixIcon: IconButton(
            icon: GradientWidget(
              gradient: GradientConstants.gradient1,
              child: Icon(
                Icons.clear_rounded,
                color: ColorConstants.accent50,
              ),
            ),
            onPressed: () {
              setState(
                () {
                  _emailController.clear();
                },
              );
            },
          ),
          contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
          labelText: 'Email',
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 16,
              color: _emailLabelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.mono15, width: 1.8),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 2.1,
            gradient: GradientConstants.gradient1,
            borderRadius: BorderRadius.circular(6),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.fail, width: 2.1),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.fail, width: 2.1),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );

    //Button Enabled Linear Gradient
    final enabledGradient = GradientConstants.gradient1;

    //Button Disabled Linear Gradient
    final disabledGradient = GradientConstants.gradient2;

    //Next Button
    final nextButton = Container(
      alignment: Alignment.centerRight,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: BoxDecoration(
            gradient: _enableNextButton ? enabledGradient : disabledGradient,
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
            onPressed: _enableNextButton
                ? () => _emailExistsCheck(_emailController.text)
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 15),
                Text(
                  'Next',
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

    //Dot Progress Bar
    final dotProgressBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GradientWidget(
          gradient: GradientConstants.gradient2,
          child: Icon(
            Icons.circle,
            color: ColorConstants.accent50,
            size: 12,
          ),
        ),
        const SizedBox(width: 6),
        GradientWidget(
          gradient: GradientConstants.gradient1,
          child: Icon(
            Icons.circle,
            color: ColorConstants.accent50,
            size: 12,
          ),
        ),
        const SizedBox(width: 6),
        GradientWidget(
          gradient: GradientConstants.gradient2,
          child: Icon(
            Icons.circle,
            color: ColorConstants.accent50,
            size: 12,
          ),
        ),
      ],
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
              onChanged: () => setState(
                () => _enableNextButton = _formKey.currentState!.validate(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 150),
                  titleMessage,
                  const SizedBox(height: 36),
                  //Bottom Section
                  Container(
                    height: 450.0,
                    padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        instructions,
                        const SizedBox(height: 30),
                        emailField,
                        const SizedBox(height: 30),
                        nextButton,
                        const SizedBox(height: 66),
                        dotProgressBar,
                        const SizedBox(height: 72),
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

  Future<void> _emailExistsCheck(String email) async {
    void getLength(List<String> emailList) {
      buttonPressResult(emailList.length);
    }

    _auth.fetchSignInMethodsForEmail(email).then((value) => getLength(value));
  }

  void buttonPressResult(int length) {
    if (length == 0) {
      AutoRouter.of(context).push(
        RegisterPasswordRoute(
            username: widget.username, email: _emailController.text),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorConstants.mono10,
          behavior: SnackBarBehavior.floating,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: ColorConstants.fail,
              ),
              Text(
                ' Email Already Exists',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: ColorConstants.fail,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
