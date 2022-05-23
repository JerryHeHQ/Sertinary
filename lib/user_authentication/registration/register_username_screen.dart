// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import "package:google_fonts/google_fonts.dart";

class RegisterUsernameScreen extends StatefulWidget {
  const RegisterUsernameScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUsernameScreen> createState() => _RegisterUsernameScreenState();
}

class _RegisterUsernameScreenState extends State<RegisterUsernameScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //text editing controller
  final TextEditingController _usernameController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _usernameLabelColor = ColorConstants.mono75;

  @override
  Widget build(BuildContext context) {
    //username form field
    final usernameField = Focus(
      onFocusChange: (hasFocus) {
        setState(() => _usernameLabelColor =
            hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
      },
      child: TextFormField(
        autofocus: false,
        controller: _usernameController,
        keyboardType: TextInputType.name,
        //validator:(value) { },
        onSaved: (value) {
          _usernameController.text = value!;
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
            Icons.person,
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
                  _usernameController.clear();
                },
              );
            },
          ),
          contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
          labelText: "Username",
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 16,
              color: _usernameLabelColor,
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
          onPressed: () {},
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
                  //Back To Login Screen Button
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
                          "Hey there!\nLet's get you started!",
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
                                "What would you like us\nto call you?",
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
                          usernameField,
                          const SizedBox(height: 30),
                          //Next Button
                          Container(
                            alignment: Alignment.centerRight,
                            child: nextButton,
                          ),
                          const SizedBox(height: 150),
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
