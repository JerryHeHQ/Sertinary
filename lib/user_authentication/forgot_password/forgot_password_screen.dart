import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
    //Back Button
    final backButton = Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          size: 45,
        ),
        color: ColorConstants.mono05,
        onPressed: () {
          AutoRouter.of(context).pop();
        },
      ),
    );

    //Title Message
    final titleMessage = Padding(
      padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'No worries.\nWe got you covered.',
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

    //Instructions
    final instructions = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enter your email to begin\nresetting your password.',
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
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          fillColor: ColorConstants.mono10,
          filled: true,
          prefixIcon: Icon(
            Icons.mail,
            color: ColorConstants.accent50,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear_rounded,
              color: ColorConstants.accent50,
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
              fontWeight: FontWeight.w400,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.mono15, width: 1.8),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.accent50, width: 2.1),
            borderRadius: BorderRadius.circular(18),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.fail, width: 2.1),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.fail, width: 2.1),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );

    //Button Enabled Linear Gradient
    final enabledGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.0, 0.5, 1.0],
      colors: [
        ColorConstants.accent30,
        ColorConstants.accent50,
        ColorConstants.accent30,
      ],
    );

    //Button Disabled Linear Gradient
    final disabledGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.0, 0.5, 1.0],
      colors: [
        ColorConstants.mono30,
        ColorConstants.mono50,
        ColorConstants.mono30,
      ],
    );

    //Next Button
    final nextButton = Container(
      alignment: Alignment.centerRight,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            gradient: _enableNextButton ? enabledGradient : disabledGradient,
            borderRadius: BorderRadius.circular(18),
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
              onChanged: () => setState(
                () => _enableNextButton = _formKey.currentState!.validate(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  backButton,
                  const SizedBox(height: 90),
                  titleMessage,
                  const SizedBox(height: 36),
                  //Bottom Section
                  Container(
                    height: 450.0,
                    padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
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
                        instructions,
                        const SizedBox(height: 30),
                        emailField,
                        const SizedBox(height: 30),
                        nextButton,
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

  Future<void> _emailExistsCheck(String email) async {
    void getLength(List<String> emailList) {
      resetPassword(emailList.length, email);
    }

    _auth.fetchSignInMethodsForEmail(email).then((value) => getLength(value));
  }

  void resetPassword(int length, String email) {
    if (length > 0) {
      //If A User With This Email Exists
      try {
        _auth.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (error) {
        String errorMessage = '';
        switch (error.code) {
          case 'invalid-email':
            errorMessage = 'The email address entered is invalid.';
            break;
          case 'wrong-password':
            errorMessage = 'The password entered is incorrect.';
            break;
          case 'user-not-found':
            errorMessage = 'A user with this email was not found.';
            break;
          case 'user-disabled':
            errorMessage = 'The user with this email has been disabled.';
            break;
          case 'too-many-requests':
            errorMessage = 'ERROR: Too many requests.';
            break;
          case 'operation-not-allowed':
            errorMessage =
                'ERROR: Signing in with email and password is disabled.';
            break;
          default:
            errorMessage = 'ERROR: Unknown';
        }
        failSnackBar(errorMessage); //Send Fail Message
        return; //Get Out Of Method
      }
      successSnackBar(); //Send Success Message
    } else {
      String errorMessage = 'User Does Not Exist';
      failSnackBar(errorMessage); //Send User Does Not Exist Message
    }
  }

  void failSnackBar(String errorMessage) {
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
              ' $errorMessage',
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

  void successSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConstants.mono10,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.send,
              color: ColorConstants.success,
            ),
            Text(
              ' A Password Reset Link Has Been Sent',
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
    );
  }
}
