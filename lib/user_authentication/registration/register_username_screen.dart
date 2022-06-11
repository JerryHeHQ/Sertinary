import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

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
    //Title Message
    final titleMessage = Padding(
      padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hey there!\nLet\'s get you started!',
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
          'What would you like us\nto call you?',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 21,
              color: ColorConstants.accent50,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
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
              return ('Please Enter Your Preferred Username');
            }
            if (!RegExp(r'^[A-Za-z]').hasMatch(value)) {
              return ('The First Character Must Be A Letter');
            }
            if (!RegExp(r'^.{3,}$').hasMatch(value)) {
              return ('Your Username Must Be At Least 3 Characters Long');
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
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            fillColor: ColorConstants.mono10,
            filled: true,
            prefixIcon: GradientWidget(
              gradient: GradientConstants.gradient1,
              child: Icon(
                Icons.person,
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
                    _usernameController.clear();
                  },
                );
              },
            ),
            contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
            labelText: 'Username',
            labelStyle: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
                color: _usernameLabelColor,
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
                ? () => AutoRouter.of(context).push(
                      RegisterEmailRoute(username: _usernameController.text),
                    )
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30),
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
