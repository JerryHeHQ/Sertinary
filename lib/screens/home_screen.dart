import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.alarm_rounded,
        size: 30,
        color: ColorConstants.mono90,
      ),
      Icon(
        Icons.search_rounded,
        size: 30,
        color: ColorConstants.mono90,
      ),
      Icon(
        Icons.favorite_border_rounded,
        size: 30,
        color: ColorConstants.mono90,
      ),
      Icon(
        Icons.list_alt_rounded,
        size: 30,
        color: ColorConstants.mono90,
      ),
      Icon(
        Icons.person_outline_rounded,
        size: 30,
        color: ColorConstants.mono90,
      ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: ColorConstants.mono05,
      body: Center(
        child: Text('$currentIndex'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        items: items,
        color: ColorConstants.mono10,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: ColorConstants.accent50,
        animationCurve: Curves.easeOut,
        animationDuration: const Duration(milliseconds: 300),
        index: currentIndex, //Starts At Index 2
        onTap: (currentIndex) =>
            setState(() => this.currentIndex = currentIndex),
      ),
    );
  }
}
