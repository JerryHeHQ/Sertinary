// ignore_for_file: unused_import, depend_on_referenced_packages
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
import "package:google_fonts/google_fonts.dart";

bool _passwordVisible = false;

void initState() {
  _passwordVisible = false;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _emailLabelColor = ColorConstants.mono75;
  Color _passwordLabelColor = ColorConstants.mono75;

  @override
  Widget build(BuildContext context) {
    //email form field
    final emailField = Focus(
      onFocusChange: (hasFocus) {
        setState(() => _emailLabelColor =
            hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
      },
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        //validator:(value) { },
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
          labelText: "Email",
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
        ),
      ),
    );

    //password form field
    final passwordField = Focus(
      onFocusChange: (hasFocus) {
        setState(() => _passwordLabelColor =
            hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
      },
      child: TextFormField(
        autofocus: false,
        controller: _passwordController,
        obscureText: !_passwordVisible,
        //validator:(value) { },
        onSaved: (value) {
          _passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
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
            Icons.vpn_key,
            color: ColorConstants.accent50,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: ColorConstants.accent50,
            ),
            onPressed: () {
              setState(
                () {
                  _passwordVisible = !_passwordVisible;
                },
              );
            },
          ),
          contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
          labelText: "Password",
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 16,
              color: _passwordLabelColor,
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
        ),
      ),
    );

    //login button
    final loginButton = Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
            colors: [
              ColorConstants.accent30,
              ColorConstants.accent50,
              ColorConstants.accent30,
            ],
          ),
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(18),
        ),
        child: MaterialButton(
          height: 54,
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {},
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 21,
                color: ColorConstants.mono05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: ColorConstants.mono05,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: ColorConstants.mono05,
            child: Padding(
              padding: const EdgeInsets.all(21),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/images/SertinaryLogo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 60),
                    emailField,
                    const SizedBox(height: 15),
                    passwordField,
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Forgot Password?",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 13,
                              color: ColorConstants.mono60,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    const SizedBox(height: 30),
                    loginButton,
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 13,
                              color: ColorConstants.mono60,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: ColorConstants.accent50,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
