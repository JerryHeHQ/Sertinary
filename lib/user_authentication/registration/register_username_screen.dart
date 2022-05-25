// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_email_screen.dart';

class RegisterUsernameScreen extends StatefulWidget {
  const RegisterUsernameScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUsernameScreen> createState() => _RegisterUsernameScreenState();
}

class _RegisterUsernameScreenState extends State<RegisterUsernameScreen> {
  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final TextEditingController _usernameController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _usernameLabelColor = ColorConstants.mono75;

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
          Navigator.of(context).pop();
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
    );

    //Instructions
    final instructions = Row(
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
    );

    //Username Form Field
    final usernameField = Container(
      alignment: Alignment.centerRight,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() => _usernameLabelColor =
              hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
        },
        child: TextFormField(
          autofocus: false,
          controller: _usernameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please Enter Your Preferred Username");
            }
            if (!RegExp(r'^[A-Za-z]').hasMatch(value)) {
              return ("The First Character Must Be A Letter");
            }
            if (!RegExp(r'^.{3,}$').hasMatch(value)) {
              return ("Your Username Must Be At Least 3 Characters Long");
            }
            return null;
          },
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
              borderSide:
                  BorderSide(color: ColorConstants.accent50, width: 2.1),
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
                ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterEmailScreen(),
                      ),
                    )
                : null,
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
      ),
    );

    //Dot Progress Bar
    final dotProgressBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
                        usernameField,
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
}
