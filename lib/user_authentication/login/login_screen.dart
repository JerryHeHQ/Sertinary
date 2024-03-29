import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/form_field_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

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
  //Firebase
  final _auth = FirebaseAuth.instance;

  //Form Keys
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  //Scaffold Key
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Text Editing Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _emailLabelColor = ColorConstants.mono75;
  Color _passwordLabelColor = ColorConstants.mono75;

  //Changes LoginButton State Based On TextFormField Inputs
  bool _enableLoginButton = false;

  @override
  Widget build(BuildContext context) {
    //Sertinary Logo
    final sertinaryLogo = SizedBox(
      height: 200,
      child: Image.asset(
        'assets/images/SertinaryLogo.png',
        fit: BoxFit.contain,
      ),
    );

    //Email Form Field
    final emailField = Form(
      key: _emailFormKey,
      onChanged: () => setState(
        () => _enableLoginButton = _emailFormKey.currentState!.validate(),
      ),
      child: Focus(
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
                )),
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
            enabledBorder: FormFieldConstants.enabledBorder,
            focusedBorder: FormFieldConstants.focusedBorder,
            errorBorder: FormFieldConstants.errorBorder,
            focusedErrorBorder: FormFieldConstants.focusedErrorBorder,
          ),
        ),
      ),
    );

    //Password Form Field
    final passwordField = Form(
      key: _passwordFormKey,
      onChanged: () => setState(
        () => _enableLoginButton = _passwordFormKey.currentState!.validate(),
      ),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() => _passwordLabelColor =
              hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
        },
        child: TextFormField(
          autofocus: false,
          controller: _passwordController,
          obscureText: !_passwordVisible,
          validator: (value) {
            if (value!.isEmpty) {
              return ('Please Enter A Valid Password');
            }
            return null;
          },
          onSaved: (value) {
            _passwordController.text = value!;
          },
          textInputAction: TextInputAction.done,
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
                Icons.vpn_key,
                color: ColorConstants.accent50,
              ),
            ),
            suffixIcon: GradientWidget(
              gradient: GradientConstants.gradient1,
              child: IconButton(
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
            ),
            contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
            labelText: 'Password',
            labelStyle: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
                color: _passwordLabelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            enabledBorder: FormFieldConstants.enabledBorder,
            focusedBorder: FormFieldConstants.focusedBorder,
            errorBorder: FormFieldConstants.errorBorder,
            focusedErrorBorder: FormFieldConstants.focusedErrorBorder,
          ),
        ),
      ),
    );

    //Forgot Password Button
    final forgotPasswordButton = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _passwordController.clear();
            AutoRouter.of(context).push(const ForgotPasswordRoute());
          },
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 13,
                color: ColorConstants.mono60,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
      ],
    );

    //Button Enabled Linear Gradient
    final enabledGradient = GradientConstants.gradient1;

    //Button Disabled Linear Gradient
    final disabledGradient = GradientConstants.gradient2;

    //Login Button
    final loginButton = Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        decoration: BoxDecoration(
          gradient: _enableLoginButton ? enabledGradient : disabledGradient,
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
          minWidth: MediaQuery.of(context).size.width,
          onPressed: _enableLoginButton
              ? () => _login(
                    _emailController.text,
                    _passwordController.text,
                  )
              : null,
          child: Text(
            'Login',
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

    //Sign Up Button
    final signUpButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Don\'t have an account? ',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 13,
              color: ColorConstants.mono60,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _passwordController.clear();
            AutoRouter.of(context).push(
              const RegisterRoute(),
            );
          },
          child: GradientWidget(
            gradient: GradientConstants.gradient1,
            child: Text(
              'Sign Up',
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
        ),
      ],
    );

    return WillPopScope(
      //Disables Andriod Bottom Bar Back Button
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorConstants.mono05,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: ColorConstants.mono05,
              child: Padding(
                padding: const EdgeInsets.all(21),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    sertinaryLogo,
                    const SizedBox(height: 60),
                    emailField,
                    const SizedBox(height: 15),
                    passwordField,
                    const SizedBox(height: 3),
                    forgotPasswordButton,
                    const SizedBox(height: 30),
                    loginButton,
                    const SizedBox(height: 12),
                    signUpButton,
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

  //Login Function
  void _login(String email, String password) async {
    if (_emailFormKey.currentState!.validate() &&
        _passwordFormKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
          (uid) {
            _passwordController.clear();
            AutoRouter.of(context).replaceAll([const HomeRoute()]);
          },
        );
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
    }
  }
}
