// ignore_for_file: depend_on_referenced_packages

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/user_authentication/registration/user_template.dart';
import '../../constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool _passwordVisible = false;

void initState() {
  _passwordVisible = false;
}

class RegisterPasswordScreen extends StatefulWidget {
  final String username;
  final String email;
  const RegisterPasswordScreen(
      {Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  State<RegisterPasswordScreen> createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  //Firebase
  final _auth = FirebaseAuth.instance;

  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final TextEditingController _passwordController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _passwordLabelColor = ColorConstants.mono75;

  //Changes CreateAccountButton State Based On TextFormField Inputs
  bool _enableCreateAccountButton = false;

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
            "\nSecurity Time!",
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
          "Enter the password\nyou would like to use.",
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

    //Password Form Field
    final passwordField = Focus(
      onFocusChange: (hasFocus) {
        setState(() => _passwordLabelColor =
            hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
      },
      child: TextFormField(
        autofocus: false,
        controller: _passwordController,
        obscureText: !_passwordVisible,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter A Password");
          }
          if (!RegExp(r'^.{6,}$').hasMatch(value)) {
            return ("Your Password Must Be At Least 6 Characters Long");
          }
          return null;
        },
        onSaved: (value) {
          _passwordController.text = value!;
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

    //CreateAccount Button
    final createAccountButton = Container(
      alignment: Alignment.centerRight,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            gradient:
                _enableCreateAccountButton ? enabledGradient : disabledGradient,
            borderRadius: BorderRadius.circular(18),
          ),
          child: MaterialButton(
            height: 54,
            onPressed: _enableCreateAccountButton
                ? () => createAccount(_passwordController.text)
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 15),
                Text(
                  "Create Account",
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
        Icon(
          Icons.circle,
          color: ColorConstants.mono50,
          size: 12,
        ),
        const SizedBox(width: 6),
        Icon(
          Icons.circle,
          color: ColorConstants.mono50,
          size: 12,
        ),
        const SizedBox(width: 6),
        Icon(
          Icons.circle,
          color: ColorConstants.accent50,
          size: 12,
        ),
      ],
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
                () => _enableCreateAccountButton =
                    _formKey.currentState!.validate(),
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
                        instructions,
                        const SizedBox(height: 30),
                        passwordField,
                        const SizedBox(height: 30),
                        createAccountButton,
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

  Future<void> createAccount(String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: widget.email, password: password)
            .then((value) => {sendInfoToFirestore()});
      } on FirebaseAuthException catch (error) {
        String errorMessage = "";
        switch (error.code) {
          case "invalid-email":
            errorMessage = "The email address entered is invalid.";
            break;
          case "wrong-password":
            errorMessage = "The password entered is incorrect.";
            break;
          case "user-not-found":
            errorMessage = "A user with this email was not found.";
            break;
          case "user-disabled":
            errorMessage = "The user with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "ERROR: Too many requests.";
            break;
          case "operation-not-allowed":
            errorMessage =
                "ERROR: Signing in with email and password is disabled.";
            break;
          default:
            errorMessage = "ERROR: Unknown";
        }
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
                  " $errorMessage",
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

  sendInfoToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserTemplate userTemplate = UserTemplate();

    userTemplate.uid = user!.uid;
    userTemplate.username = widget.username;
    userTemplate.email = user.email;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userTemplate.toMap());

    goToRegisterVerifyScreen();
  }

  void goToRegisterVerifyScreen() {
    AutoRouter.of(context).push(const RegisterVerifyRoute());
  }
}
