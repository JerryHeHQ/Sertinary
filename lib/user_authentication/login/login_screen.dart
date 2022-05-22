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

  @override
  Widget build(BuildContext context) {
    //email form field
    final emailField = TextFormField(
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
        fontSize: 15,
        color: ColorConstants.white,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
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
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
        labelStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 15,
            color: ColorConstants.accent50,
            fontWeight: FontWeight.w500,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.black, width: 2.1),
          borderRadius: BorderRadius.circular(9),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.accent50, width: 3.0),
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    );

    //password form field
    final passwordField = TextFormField(
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
        fontSize: 15,
        color: ColorConstants.white,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
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
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Password",
        labelStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 15,
            color: ColorConstants.accent50,
            fontWeight: FontWeight.w500,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.black, width: 2.1),
          borderRadius: BorderRadius.circular(9),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.accent50, width: 3.0),
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    );

    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(9),
      color: ColorConstants.accent50,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 21,
              color: ColorConstants.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: ColorConstants.mono10,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: ColorConstants.mono10,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
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
                    const SizedBox(height: 30),
                    loginButton,
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: ColorConstants.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: ColorConstants.accent50,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
