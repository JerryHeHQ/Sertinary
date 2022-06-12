import 'dart:async';

import 'package:animate_icons/animate_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/common_functions.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/main.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/bottom_navigation_bar/gbutton.dart';
import 'package:sertinary/widgets/bottom_navigation_bar/gnav.dart';
import 'package:sertinary/widgets/gradient_widget.dart';
import 'package:sertinary/widgets/sub_buttons/circular_button.dart';
import 'package:sertinary/widgets/sub_buttons/sub_button_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //Animation Controller For The SubButtons (The Buttons That Pop Out When The Floating Action Button Is Pressed)
  late AnimationController subButtonAnimationController;
  //Animations For Each SubButton (1-3 Is Numbered From Left To Right)
  late Animation subButtonOneAnimation;
  late Animation subButtonTwoAnimation;
  late Animation subButtonThreeAnimation;
  //Animation For Rotating The SubButtons
  late Animation subButtonRotationAnimation;

  //Animation Controller For Rotating The Floating Action Button
  late AnimateIconController fabIconAnimationController;

  //Variable To Be Used As A Delay Before Animations Can Be Played Again (Prevents Visual Bugs)
  bool canAnimateAgain = true;

  //Holds Current Index Of The Active Tab & Screen
  late int _selectedIndex;

  //The Icons Used By The SubButtons (Declared Here So The updateSubButtonIcons() Method Can Access Them)
  late Icon subButtonOneIcon;
  late Icon subButtonTwoIcon;
  late Icon subButtonThreeIcon;

  @override
  void initState() {
    super.initState();

    subButtonAnimationController = AnimationController(
      vsync: this,
      //Duration Of Entire SubButton Animation
      duration: const Duration(milliseconds: 360),
    );
    subButtonOneAnimation = TweenSequence([
      //Extends Beyond Final Location & Grows Beyond Final Size
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 30.0),
      //Rebounds To Final Location & Final Size
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 50.0),
      //Waits For Other SubButtons To Finish Animating
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 1.0), weight: 20.0),
    ]).animate(subButtonAnimationController);
    subButtonTwoAnimation = TweenSequence([
      //Extends Beyond Final Location & Grows Beyond Final Size
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 50.0),
      //Rebounds To Final Location & Final Size
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 40.0),
      //Waits For Other SubButtons To Finish Animating
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 1.0), weight: 10.0),
    ]).animate(subButtonAnimationController);
    subButtonThreeAnimation = TweenSequence([
      //Extends Beyond Final Location & Grows Beyond Final Size
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      //Rebounds To Final Location & Final Size
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(subButtonAnimationController);
    //Rotates SubButtons Clockwise From Upside Down To Rightside Up
    subButtonRotationAnimation = Tween<double>(begin: 180.0, end: 360.0)
        .animate(CurvedAnimation(
            parent: subButtonAnimationController, curve: Curves.easeOut));

    //Calls setState() If Animation Changes (Needed For Animation To Run Properly)
    subButtonAnimationController.addListener(() {
      setState(() {});
    });

    fabIconAnimationController = AnimateIconController();

    //Begins Each SubButton To Have A Blank Icon Since No Tab/Screen Has Been Selected
    subButtonOneIcon = SubButtonIcons.blankIcon;
    subButtonTwoIcon = SubButtonIcons.blankIcon;
    subButtonThreeIcon = SubButtonIcons.blankIcon;

    //Initializes To 0 To Display Starting Screen
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    //Height Of BottomAppBar
    double botAppBarHeight = 45;
    //Space Between The Two GNavs
    double gapWidth = 72;
    //Width Of Each GNav Without Padding
    double gNavWidth = MediaQuery.of(context).size.width / 2 - gapWidth / 2;

    return AutoTabsRouter(
      routes: const [
        WelcomeRouter(),
        AlarmsRouter(),
        SocialRouter(),
        TrackerRouter(),
        PlannerRouter(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return WillPopScope(
          //Disables Andriod Bottom Bar Back Button
          onWillPop: () async => false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            //Extend Past BottomNavigationBar
            extendBody: true,
            extendBodyBehindAppBar: true,
            //Background Color
            backgroundColor: Colors.transparent,
            //Screens & FloatingActionButton & SubButtons
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //Screens
                child,
                //'Floating Action Button' (Same Function But Not Same Widget) & SubButtons
                Positioned(
                  bottom: 27,
                  child: Stack(
                    //Allows Overflow To Be Rendered
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: <Widget>[
                      //SubButtonOne (Only Used For Animation)
                      Transform.translate(
                        offset: Offset.fromDirection(
                            CommonFunctions.degreesToRadians(210),
                            subButtonOneAnimation.value * 60),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              CommonFunctions.degreesToRadians(
                                  subButtonRotationAnimation.value))
                            ..scale(subButtonOneAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            width: 40,
                            height: 40,
                            icon: subButtonOneIcon,
                            onClick: () {},
                          ),
                        ),
                      ),
                      //SubButtonTwo (Only Used For Animation)
                      Transform.translate(
                        offset: Offset.fromDirection(
                            CommonFunctions.degreesToRadians(270),
                            subButtonTwoAnimation.value * 60),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              CommonFunctions.degreesToRadians(
                                  subButtonRotationAnimation.value))
                            ..scale(subButtonTwoAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            width: 40,
                            height: 40,
                            icon: subButtonTwoIcon,
                            onClick: () {},
                          ),
                        ),
                      ),
                      //SubButtonThree (Only Used For Animation)
                      Transform.translate(
                        offset: Offset.fromDirection(
                            CommonFunctions.degreesToRadians(330),
                            subButtonThreeAnimation.value * 60),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              CommonFunctions.degreesToRadians(
                                  subButtonRotationAnimation.value))
                            ..scale(subButtonThreeAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            width: 40,
                            height: 40,
                            icon: subButtonThreeIcon,
                            onClick: () {},
                          ),
                        ),
                      ),
                      //Floating Action Button Background (Only Used For Visuals)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: GradientConstants.gradient1,
                        ),
                        width: 60,
                        height: 60,
                        child: IconButton(
                            icon: SubButtonIcons.blankIcon,
                            enableFeedback: true,
                            onPressed: () {}),
                      ),
                      //FLoating Action Button Animation (Only Used For Visuals)
                      AnimateIcons(
                        startIcon: Icons.keyboard_arrow_up_outlined,
                        endIcon: Icons.keyboard_arrow_down_outlined,
                        controller: fabIconAnimationController,
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
                      //Floating Action Button Interaction Surface (Needed So Overlapping Widgets Do Not Interfere With Interaction Area)
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        width: 60,
                        height: 60,
                        child: IconButton(
                          icon: SubButtonIcons.blankIcon,
                          enableFeedback: true,
                          onPressed: () {
                            subButtonsActive.value = false;
                            animateSubButtons(true);
                          },
                        ),
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
              child: SafeArea(
                child: Padding(
                  //Gives Vertical Padding Between GNavs And BottomAppBar
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  //Stack To Hold GNavs
                  child: Stack(
                    //Aligns Sized Box (Creates Gap Between GNavs) To Center Of Bottom App Bar
                    alignment: Alignment.center,
                    children: [
                      //Left GNav Holder
                      Positioned(
                        //Distance Left GNav Extends Beyond The Screen
                        left: -gapWidth,
                        child: SizedBox(
                          //GNavWidth Is Actual GNav Size
                          //2 * GapWidth Is Extendable Padding
                          width: gNavWidth + 2 * gapWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Left GNav
                              GradientWidget(
                                gradient: GradientConstants.gradient1,
                                child: GNav(
                                  //Index The First GButton (Tab) Relative To Screens
                                  minIndex: 1,
                                  //Boolean For Whether Any GButton (Tab) In The Right GNav Is Active
                                  isActive: (_selectedIndex == 1 ||
                                      _selectedIndex == 2),
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
                                  //Text Style Of GButton Text (Overrides Active Color)
                                  textStyle: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.6),
                                  ),
                                  rippleColor: Colors.red,
                                  //Size Of GButton Icons
                                  iconSize: 24,
                                  //Duration Of GButton Animation
                                  duration: const Duration(milliseconds: 180),
                                  //Padding Between GButton And Its Background
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 12),
                                  //GButton Background Corner Radius
                                  tabBorderRadius: 9,
                                  //List Of GButtons
                                  tabs: const [
                                    GButton(
                                      icon: Icons.alarm_outlined,
                                      text: 'Alarms',
                                    ),
                                    GButton(
                                      icon: Icons.person_pin_outlined,
                                      text: 'Social',
                                    ),
                                  ],
                                  //Gives GNav The SelectedIndex
                                  selectedIndex: _selectedIndex,
                                  //Function When A Different GButton (Tab) Is Selected
                                  onTabChange: (index) {
                                    setState(() {
                                      subButtonsActive.value = false;
                                      //Updates The Class Variable For Use In Other Parts Of The Class
                                      _selectedIndex = index;
                                      //Tells TabsRouter To Change Screen To Corresponding Tab
                                      tabsRouter.setActiveIndex(_selectedIndex);
                                      //Changes Sub Buttons To Blank During Transition
                                      updateSubButtonIcons(0);
                                      //A Call To Close The FloatingActionButton's Sub-Buttons Only If They Are Opened
                                      animateSubButtons(false);
                                      //After Sub Button Animation Is Done, Each Sub Button Icon Will Have The Icons Corresponding To The Current Screen
                                      Future.delayed(
                                          const Duration(milliseconds: 360),
                                          () {
                                        updateSubButtonIcons(_selectedIndex);
                                      });
                                    });
                                  },
                                ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Right GNav
                              GradientWidget(
                                gradient: GradientConstants.gradient1,
                                child: GNav(
                                  //Index The First GButton (Tab) Relative To Screens
                                  minIndex: 3,
                                  //Boolean For Whether Any GButton (Tab) In The Right GNav Is Active
                                  isActive: (_selectedIndex == 3 ||
                                      _selectedIndex == 4),
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
                                  //Text Style Of GButton Text (Overrides Active Color)
                                  textStyle: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.6),
                                  ),
                                  rippleColor: Colors.red,
                                  //Size Of GButton Icons
                                  iconSize: 24,
                                  //Duration Of GButton Animation
                                  duration: const Duration(milliseconds: 180),
                                  //Padding Between GButton And Its Background
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 12),
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
                                      subButtonsActive.value = false;
                                      //Updates The Class Variable For Use In Other Parts Of The Class
                                      _selectedIndex = index;
                                      //Tells TabsRouter To Change Screen To Corresponding Tab
                                      tabsRouter.setActiveIndex(_selectedIndex);
                                      //Changes Sub Buttons To Blank During Transition
                                      updateSubButtonIcons(0);
                                      //A Call To Close The FloatingActionButton's Sub-Buttons Only If They Are Opened
                                      animateSubButtons(false);
                                      //After Sub Button Animation Is Done, Each Sub Button Icon Will Have The Icons Corresponding To The Current Screen
                                      Future.delayed(
                                          const Duration(milliseconds: 360),
                                          () {
                                        updateSubButtonIcons(_selectedIndex);
                                      });
                                    });
                                  },
                                ),
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
            //Location Of Floating Action Button (Center Of Screen Just Above Bottom Navigation Bar)
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
  }

  //Animates Sub Buttons (Allowed To Close, But Only Allowed To Open If allowOpen Is True)
  void animateSubButtons(bool allowOpen) {
    //If Animation Cooldown Is Not Over, It Will Not Animate
    if (!canAnimateAgain) {
      return;
    }

    //If The Animation Is At The Start & Opening Is Allowed, Open SubButtons
    if (!subButtonAnimationController.isCompleted && allowOpen) {
      subButtonAnimationController.forward();
    }
    //Otherwise Close The SubButtons
    else {
      subButtonAnimationController.reverse();
    }

    //If The Animation Is At The Start & Opening Is Allowed, Rotate FAB Icon To Opened Position
    if (fabIconAnimationController.isStart() && allowOpen) {
      fabIconAnimationController.animateToEnd();
    }
    //Otherwise Rotate FAB Icon To Closed Position
    else {
      fabIconAnimationController.animateToStart();
    }

    //After An Animation, You Can No Longer Animate For A Cooldown Period
    canAnimateAgain = false;
    Future.delayed(
      const Duration(milliseconds: 510),
      () {
        if (subButtonAnimationController.isCompleted) {
          subButtonsActive.value = true;
        } else {
          subButtonsActive.value = false;
        }
        canAnimateAgain = true;
      },
    );
  }

  //Changes Sub Button Icons To The Icons Based On Current Screen
  void updateSubButtonIcons(int index) {
    switch (index) {
      case 0:
        subButtonOneIcon = SubButtonIcons.blankIcon;
        subButtonTwoIcon = SubButtonIcons.blankIcon;
        subButtonThreeIcon = SubButtonIcons.blankIcon;
        break;
      case 1:
        subButtonOneIcon = SubButtonIcons.alarmsSubButtonOneIcon;
        subButtonTwoIcon = SubButtonIcons.alarmsSubButtonTwoIcon;
        subButtonThreeIcon = SubButtonIcons.alarmsSubButtonThreeIcon;
        break;
      case 2:
        subButtonOneIcon = SubButtonIcons.socialSubButtonOneIcon;
        subButtonTwoIcon = SubButtonIcons.socialSubButtonTwoIcon;
        subButtonThreeIcon = SubButtonIcons.socialSubButtonThreeIcon;
        break;
      case 3:
        subButtonOneIcon = SubButtonIcons.trackerSubButtonOneIcon;
        subButtonTwoIcon = SubButtonIcons.trackerSubButtonTwoIcon;
        subButtonThreeIcon = SubButtonIcons.trackerSubButtonThreeIcon;
        break;
      case 4:
        subButtonOneIcon = SubButtonIcons.plannerSubButtonOneIcon;
        subButtonTwoIcon = SubButtonIcons.plannerSubButtonTwoIcon;
        subButtonThreeIcon = SubButtonIcons.plannerSubButtonThreeIcon;
        break;
    }
  }
}
