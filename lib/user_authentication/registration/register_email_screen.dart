// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import "package:google_fonts/google_fonts.dart";
import 'register_password_screen.dart';

class RegisterEmailScreen extends StatefulWidget {
  const RegisterEmailScreen({Key? key}) : super(key: key);

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final TextEditingController _emailController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _emailLabelColor = ColorConstants.mono75;

  @override
  Widget build(BuildContext context) {
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

    //Next Button
    final nextButton = Material(
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPasswordScreen(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 15),
              Text(
                "Next",
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
          color: ColorConstants.accent50,
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
          color: ColorConstants.mono50,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  //Back Button
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 45,
                      ),
                      color: ColorConstants.mono05,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(height: 90),
                  //Title Message
                  Padding(
                    padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nice to meet you\n[Username]!",
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
                  ),
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
                          //Intructions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Enter your email to start\ncreating your account.",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 21,
                                    color: ColorConstants.accent50,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          //Email TextFormField
                          emailField,
                          const SizedBox(height: 30),
                          //Next Button
                          Container(
                            alignment: Alignment.centerRight,
                            child: nextButton,
                          ),
                          const SizedBox(height: 66),
                          //Dot Progress Bar
                          dotProgressBar,
                          const SizedBox(height: 72),
                        ]),
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
