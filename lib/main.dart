import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sertinary/routes/router.gr.dart';

//Global Variable So All Home Page Screens Can Properly React To Sub Button Presses
ValueNotifier<bool> subButtonsActive = ValueNotifier<bool>(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
