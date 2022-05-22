// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
import "package:google_fonts/google_fonts.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Color _emailLabelColor = ColorConstants.black;
  Color _passwordLabelColor = ColorConstants.black;

  @override
  Widget build(BuildContext context) {
    //email form field
    final emailField = Focus(
      onFocusChange: (hasFocus) {
        setState(() => _emailLabelColor =
            hasFocus ? ColorConstants.accent50 : ColorConstants.black);
      },
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        //validator:(value) { },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        cursorColor: ColorConstants.accent50,
        style: TextStyle(
          fontSize: 15,
          color: ColorConstants.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: ColorConstants.accent50,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Email",
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 15,
              color: _emailLabelColor,
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
      ),
    );

    //password form field
    final passwordField = Focus(
      onFocusChange: (hasFocus) {
        setState(() => _passwordLabelColor =
            hasFocus ? ColorConstants.accent50 : ColorConstants.black);
      },
      child: TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        //validator:(value) { },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        cursorColor: ColorConstants.accent50,
        style: TextStyle(
          fontSize: 15,
          color: ColorConstants.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: ColorConstants.accent50,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Password",
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 15,
              color: _passwordLabelColor,
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
      backgroundColor: ColorConstants.mono15,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: ColorConstants.mono15,
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
                    const SizedBox(height: 9),
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
                              color: ColorConstants.black,
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
