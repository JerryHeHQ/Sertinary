import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/widgets/bottom_navigation_bar/gnav.dart';
import 'package:sertinary/widgets/bottom_navigation_bar/gbutton.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:animate_icons/animate_icons.dart';
import 'dart:async';
import 'package:sertinary/widgets/floating_action_button/circular_button.dart';
import 'welcome_screens/welcome_screen.dart';
import 'alarms_screens/alarms_screen.dart';
import 'search_screens/search_screen.dart';
import 'tracker_screens/tracker_screen.dart';
import 'planner_screens/planner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController buttonAnimationController;
  late Animation buttonOneAnimation, buttonTwoAnimation, buttonThreeAnimation;
  late Animation buttonRotationAnimation;

  late AnimateIconController iconAnimationController;

  bool canAnimateAgain = true;

  @override
  void initState() {
    buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    buttonOneAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 30.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 50.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 1.0), weight: 20.0),
    ]).animate(buttonAnimationController);
    buttonTwoAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 50.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 40.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 1.0), weight: 10.0),
    ]).animate(buttonAnimationController);
    buttonThreeAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(buttonAnimationController);
    buttonRotationAnimation = Tween<double>(begin: 180.0, end: 360.0).animate(
        CurvedAnimation(
            parent: buttonAnimationController, curve: Curves.easeOut));
    iconAnimationController = AnimateIconController();
    super.initState();
    buttonAnimationController.addListener(() {
      setState(() {});
    });
  }

  //Begins On Tab 0
  int _selectedIndex = 0;

  //Placeholder
  static final List<Widget> _screens = <Widget>[
    const WelcomeScreen(text: "Welcome"),
    const AlarmsScreen(text: "Alarms"),
    const SearchScreen(text: "Searches"),
    const TrackerScreen(text: "Tracker"),
    const PlannerScreen(text: "Planner"),
  ];

  @override
  Widget build(BuildContext context) {
    //Height Of BottomAppBar
    double botAppBarHeight = 45;
    //Space Between The Two GNavs
    double gapWidth = 72;
    //Width Of Each GNav Without Padding
    double gNavWidth = MediaQuery.of(context).size.width / 2 - gapWidth / 2;

    return Scaffold(
      //Extend Past BottomNavigationBar
      extendBody: true,
      //Background Color
      backgroundColor: ColorConstants.monoAA,
      //Screens
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _screens.elementAt(_selectedIndex),
          Positioned(
            bottom: 27,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Transform.translate(
                  offset: Offset.fromDirection(
                      degreesToRadians(210), buttonOneAnimation.value * 60),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        degreesToRadians(buttonRotationAnimation.value))
                      ..scale(buttonOneAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      width: 40,
                      height: 40,
                      color: ColorConstants.mono05,
                      icon: Icon(
                        Icons.person,
                        color: ColorConstants.mono90,
                      ),
                      onClick: () {},
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(
                      degreesToRadians(270), buttonTwoAnimation.value * 60),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        degreesToRadians(buttonRotationAnimation.value))
                      ..scale(buttonTwoAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      width: 40,
                      height: 40,
                      color: ColorConstants.mono05,
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: ColorConstants.mono90,
                      ),
                      onClick: () {},
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(
                      degreesToRadians(330), buttonThreeAnimation.value * 60),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        degreesToRadians(buttonRotationAnimation.value))
                      ..scale(buttonThreeAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      width: 40,
                      height: 40,
                      color: ColorConstants.mono05,
                      icon: Icon(
                        Icons.menu,
                        color: ColorConstants.mono90,
                      ),
                      onClick: () {},
                    ),
                  ),
                ),
                CircularButton(
                  width: 60,
                  height: 60,
                  color: ColorConstants.accent50,
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.transparent,
                  ),
                  onClick: () {},
                ),
                AnimateIcons(
                  startIcon: Icons.keyboard_arrow_up,
                  endIcon: Icons.keyboard_arrow_down,
                  controller: iconAnimationController,
                  size: 30,
                  onStartIconPress: () {
                    return false;
                  },
                  onEndIconPress: () {
                    return false;
                  },
                  duration: const Duration(milliseconds: 250),
                  startIconColor: ColorConstants.mono05,
                  endIconColor: ColorConstants.mono05,
                  clockwise: true,
                ),
                CircularButton(
                  width: 60,
                  height: 60,
                  color: Colors.transparent,
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.transparent,
                  ),
                  onClick: () {
                    animateButtons(true);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      //Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        //Makes Notch Shape
        shape: const CircularNotchedRectangle(),
        //Size Of Notch
        notchMargin: 36,
        //Color Of BottomAppBar
        color: ColorConstants.mono05,
        //Safe Area
        child: SafeArea(
          //Padding
          child: Padding(
            //Gives Vertical Padding Between GNavs And BottomAppBar
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            //Stack To Hold GNavs
            child: Stack(
              //Aligns Sized Box (Creates Gap Between GNavs) To Center Of Bottom App Bar
              alignment: Alignment.center,
              //GNavs And Sized Box
              children: [
                //Left GNav Holder
                Positioned(
                  //Distance Left GNav Extends Beyond The Screen
                  left: -gapWidth,
                  //Size Constraints For Left GNav
                  child: SizedBox(
                    //GNavWidth Is Actual GNav Size
                    //2 * GapWidth Is Extendable Padding
                    width: gNavWidth + 2 * gapWidth,
                    //Row Container For Left GNav
                    child: Row(
                      //Centers Left GNav In Row
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Left GNav Holder
                      children: [
                        //Left GNav
                        GNav(
                          //Index The First GButton (Tab) Relative To Screens
                          minIndex: 1,
                          //Boolean For Whether Any GButton (Tab) In The Right GNav Is Active
                          isActive:
                              (_selectedIndex == 1 || _selectedIndex == 2),
                          //Gap Between GButton Icon And GButton Text
                          gap: 6,
                          //Distance Between GButtons When None Are Active
                          tabMargin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 12,
                          ),
                          //Distance Between GButtons When One Is Active
                          activeTabMargin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                          //Color Of GButton Icon & Text When Not Active
                          color: ColorConstants.monoAA,
                          //Color Of GButton Icon & Text When Active
                          activeColor: ColorConstants.accent50,
                          //Text Style Of GButton Text (Overrides Active Color)
                          textStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: ColorConstants.accent50,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.6),
                          ),
                          //Color Of Button Press Ripple Effect
                          rippleColor: ColorConstants.mono10,
                          //Color Of Button When You Hold It Down
                          hoverColor: ColorConstants.accent50,
                          //Size Of GButton Icons
                          iconSize: 24,
                          //Duration Of GButton Animation
                          duration: const Duration(milliseconds: 180),
                          //Padding Between GButton And Its Background
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 12),
                          //GButton Background Color
                          tabBackgroundColor: ColorConstants.mono10,
                          //GButton Background Corner Radius
                          tabBorderRadius: 9,
                          //List Of GButtons
                          tabs: const [
                            GButton(
                              icon: Icons.alarm_outlined,
                              text: 'Alarms',
                            ),
                            GButton(
                              icon: Icons.search_outlined,
                              text: 'Search',
                            ),
                          ],
                          //Gives GNav The SelectedIndex
                          selectedIndex: _selectedIndex,
                          //Function When A Different GButton (Tab) Is Selected
                          onTabChange: (index) {
                            setState(() {
                              animateButtons(false);
                              _selectedIndex = index;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //Sized Box Holder (Empty Gap Between GNavs)
                Positioned(
                  //Bottom App Bar Formatting
                  child: SizedBox(
                    //Height Of Bottom App Bar
                    height: botAppBarHeight,
                    //Width Of Gap Between GNavs
                    width: gapWidth,
                  ),
                ),
                //Right GNav Holder
                Positioned(
                  //Distance Right GNav Extends Beyond The Screen
                  right: -gapWidth,
                  //Size Constraints For Right GNav
                  child: SizedBox(
                    //GNavWidth Is Actual GNav Size
                    //2 * GapWidth Is Extendable Padding
                    width: gNavWidth + 2 * gapWidth,
                    //Row Container For Right GNav
                    child: Row(
                      //Centers Right GNav In Row
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //Right GNav Holder
                      children: [
                        //Right GNav
                        GNav(
                          //Index The First GButton (Tab) Relative To Screens
                          minIndex: 3,
                          //Boolean For Whether Any GButton (Tab) In The Right GNav Is Active
                          isActive:
                              (_selectedIndex == 3 || _selectedIndex == 4),
                          //Gap Between GButton Icon And GButton Text
                          gap: 6,
                          //Distance Between GButtons When None Are Active
                          tabMargin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 12,
                          ),
                          //Distance Between GButtons When One Is Active
                          activeTabMargin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                          //Color Of GButton Icon & Text When Not Active
                          color: ColorConstants.monoAA,
                          //Color Of GButton Icon & Text When Active
                          activeColor: ColorConstants.accent50,
                          //Text Style Of GButton Text (Overrides Active Color)
                          textStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: ColorConstants.accent50,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.6),
                          ),
                          //Color Of Button Press Ripple Effect
                          rippleColor: ColorConstants.mono10,
                          //Color Of Button When You Hold It Down
                          hoverColor: ColorConstants.accent50,
                          //Size Of GButton Icons
                          iconSize: 24,
                          //Duration Of GButton Animation
                          duration: const Duration(milliseconds: 180),
                          //Padding Between GButton And Its Background
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 12),
                          //GButton Background Color
                          tabBackgroundColor: ColorConstants.mono10,
                          //GButton Background Corner Radius
                          tabBorderRadius: 9,
                          //List Of GButtons
                          tabs: const [
                            GButton(
                              icon: Icons.food_bank_outlined,
                              text: 'Tracker',
                            ),
                            GButton(
                              icon: Icons.list_alt_outlined,
                              text: 'Planner',
                            ),
                          ],
                          //Gives GNav The SelectedIndex
                          selectedIndex: _selectedIndex,
                          //Function When A Different GButton (Tab) Is Selected
                          onTabChange: (index) {
                            setState(() {
                              animateButtons(false);
                              _selectedIndex = index;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //Invisible & Non-Interactable FloatingActionButton (Only Needed To Create App Bar Notch)
      floatingActionButton: SizedBox(
        width: 0,
        height: 0,
        child: FloatingActionButton(
          onPressed: () {},
        ),
      ),
      //Location Of Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  double degreesToRadians(double degree) {
    return degree / (180 / math.pi);
  }

  void animateButtons(bool openAndClose) {
    if (!canAnimateAgain) {
      return;
    }

    if (!buttonAnimationController.isCompleted && openAndClose) {
      buttonAnimationController.forward();
    } else {
      buttonAnimationController.reverse();
    }

    if (!iconAnimationController.isStart() && openAndClose) {
      iconAnimationController.animateToStart();
    } else if (iconAnimationController.isEnd()) {
      iconAnimationController.animateToEnd();
    }

    canAnimateAgain = false;

    Future.delayed(const Duration(milliseconds: 390), () {
      canAnimateAgain = true;
    });
  }
}
