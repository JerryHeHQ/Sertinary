// ignore: unused_import
import 'dart:developer';
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
import 'social_screens/social_screen.dart';
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

  //Controller For PageView
  late PageController _pageController;

  //List Of Screen Available
  late WelcomeScreen welcomeScreen;
  late AlarmsScreen alarmsScreen;
  late SocialScreen socialScreen;
  late TrackerScreen trackerScreen;
  late PlannerScreen plannerScreen;

  //List To Hold The Screens Declared Above
  late List<Widget> _screens;

  //Blank Icon For Use In Widget
  final blankIcon = const Icon(
    Icons.check_box_outline_blank,
    color: Colors.transparent,
  );
  //List Of SubButton Icons
  //---Alarms Calculator
  final alarmsSubButtonOneIcon = Icon(
    Icons.calculate_outlined,
    color: ColorConstants.monoAA,
  );
  //---Alarms Add
  final alarmsSubButtonTwoIcon = Icon(
    Icons.add_alarm_outlined,
    color: ColorConstants.monoAA,
  );
  //---Alarms Change Background
  final alarmsSubButtonThreeIcon = Icon(
    Icons.add_photo_alternate_outlined,
    color: ColorConstants.monoAA,
  );
  //---Social Saved
  final socialSubButtonOneIcon = Icon(
    Icons.favorite_border_outlined,
    color: ColorConstants.monoAA,
  );
  //---Social Add
  final socialSubButtonTwoIcon = Icon(
    Icons.add_box_outlined,
    color: ColorConstants.monoAA,
  );
  //---Social Profile
  final socialSubButtonThreeIcon = Icon(
    Icons.person_outline,
    color: ColorConstants.monoAA,
  );
  //---Tracker Overview
  final trackerSubButtonOneIcon = Icon(
    Icons.insert_chart_outlined_outlined,
    color: ColorConstants.monoAA,
  );
  //---Tracker Add
  final trackerSubButtonTwoIcon = Icon(
    Icons.restaurant_menu_outlined,
    color: ColorConstants.monoAA,
  );
  //---Tracker Change Date
  final trackerSubButtonThreeIcon = Icon(
    Icons.date_range_rounded,
    color: ColorConstants.monoAA,
  );
  //---Planner No Functionality Yet
  final plannerSubButtonOneIcon = Icon(
    Icons.not_interested_outlined,
    color: ColorConstants.monoAA,
  );
  //---Planner Add Event
  final plannerSubButtonTwoIcon = Icon(
    Icons.add_to_photos_outlined,
    color: ColorConstants.monoAA,
  );
  //---Planner Change Date
  final plannerSubButtonThreeIcon = Icon(
    Icons.date_range_rounded,
    color: ColorConstants.monoAA,
  );

  //The Icons Used By The SubButtons (Declared Here So The updateSubButtonIcons() Method Can Access Them)
  late Icon subButtonOneIcon;
  late Icon subButtonTwoIcon;
  late Icon subButtonThreeIcon;

  //Bottom Navigation Bar Declarations
  late GNav leftGNav;
  late GNav rightGNav;

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
    subButtonOneIcon = blankIcon;
    subButtonTwoIcon = blankIcon;
    subButtonThreeIcon = blankIcon;

    //Initializes The Screens
    welcomeScreen = const WelcomeScreen(text: "Welcome");
    alarmsScreen = const AlarmsScreen(text: "Alarms");
    socialScreen = const SocialScreen(text: "Social");
    trackerScreen = const TrackerScreen(text: "Tracker");
    plannerScreen = const PlannerScreen(text: "Planner");

    //Puts The Screens Initialized Above Into The List For Easy Access
    _screens = [
      welcomeScreen,
      alarmsScreen,
      socialScreen,
      trackerScreen,
      plannerScreen,
    ];

    //Initializes To 0 To Display Starting Screen
    _selectedIndex = 0;

    //Passes 0 To Page Controller To Begin At Screen 0 (Welcome Screen)
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    //Height Of BottomAppBar
    double botAppBarHeight = 45;
    //Space Between The Two GNavs
    double gapWidth = 72;
    //Width Of Each GNav Without Padding
    double gNavWidth = MediaQuery.of(context).size.width / 2 - gapWidth / 2;

    //Left Part Of Bottom Navigation Bar Initialization
    leftGNav = GNav(
      //Index The First GButton (Tab) Relative To Screens
      minIndex: 1,
      //Boolean For Whether Any GButton (Tab) In The Right GNav Is Active
      isActive: (_selectedIndex == 1 || _selectedIndex == 2),
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
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
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
          icon: Icons.person_pin_outlined,
          text: 'Social',
        ),
      ],
      //Gives GNav The SelectedIndex
      selectedIndex: _selectedIndex,
      //Function When A Different GButton (Tab) Is Selected
      onTabChange: (index) {
        setState(() {
          //Updates The Class Variable For Use In Other Parts Of The Class
          _selectedIndex = index;
          //Tells The PageController To Update Screen To Corresponding Index
          _pageController.jumpToPage(_selectedIndex);
          //Changes Sub Buttons To Blank During Transition
          updateSubButtonIcons(0);
          //A Call To Close The FloatingActionButton's Sub-Buttons Only If They Are Opened
          animateSubButtons(false);
          //After Sub Button Animation Is Done, Each Sub Button Icon Will Have The Icons Corresponding To The Current Screen
          Future.delayed(const Duration(milliseconds: 360), () {
            updateSubButtonIcons(_selectedIndex);
          });
        });
      },
    );
    //Right Part Of Bottom Navigation Bar Initialization
    rightGNav = GNav(
      //Index The First GButton (Tab) Relative To Screens
      minIndex: 3,
      //Boolean For Whether Any GButton (Tab) In The Right GNav Is Active
      isActive: (_selectedIndex == 3 || _selectedIndex == 4),
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
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
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
          //Updates The Class Variable For Use In Other Parts Of The Class
          _selectedIndex = index;
          //Tells The PageController To Update Screen To Corresponding Index
          _pageController.jumpToPage(_selectedIndex);
          //Changes Sub Buttons To Blank During Transition
          updateSubButtonIcons(0);
          //A Call To Close The FloatingActionButton's Sub-Buttons Only If They Are Opened
          animateSubButtons(false);
          //After Sub Button Animation Is Done, Each Sub Button Icon Will Have The Icons Corresponding To The Current Screen
          Future.delayed(const Duration(milliseconds: 360), () {
            updateSubButtonIcons(_selectedIndex);
          });
        });
      },
    );

    return Scaffold(
      //Extend Past BottomNavigationBar
      extendBody: true,
      //Background Color
      backgroundColor: ColorConstants.monoAA,
      //Screens & FloatingActionButton & SubButtons
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //Used For Bottom Navigation Bar Integration With Screen List
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),
          //"Floating Action Button" (Same Function But Not Same Widget) & SubButtons
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
                      degreesToRadians(210), subButtonOneAnimation.value * 60),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        degreesToRadians(subButtonRotationAnimation.value))
                      ..scale(subButtonOneAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      width: 40,
                      height: 40,
                      color: ColorConstants.mono05,
                      icon: subButtonOneIcon,
                      onClick: () {},
                    ),
                  ),
                ),
                //SubButtonTwo (Only Used For Animation)
                Transform.translate(
                  offset: Offset.fromDirection(
                      degreesToRadians(270), subButtonTwoAnimation.value * 60),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        degreesToRadians(subButtonRotationAnimation.value))
                      ..scale(subButtonTwoAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      width: 40,
                      height: 40,
                      color: ColorConstants.mono05,
                      icon: subButtonTwoIcon,
                      onClick: () {},
                    ),
                  ),
                ),
                //SubButtonThree (Only Used For Animation)
                Transform.translate(
                  offset: Offset.fromDirection(degreesToRadians(330),
                      subButtonThreeAnimation.value * 60),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        degreesToRadians(subButtonRotationAnimation.value))
                      ..scale(subButtonThreeAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      width: 40,
                      height: 40,
                      color: ColorConstants.mono05,
                      icon: subButtonThreeIcon,
                      onClick: () {},
                    ),
                  ),
                ),
                //Floating Action Button Background (Only Used For Visuals)
                CircularButton(
                  width: 60,
                  height: 60,
                  color: ColorConstants.accent50,
                  icon: blankIcon,
                  onClick: () {},
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
                CircularButton(
                  width: 60,
                  height: 60,
                  color: Colors.transparent,
                  icon: blankIcon,
                  onClick: () {
                    animateSubButtons(true);
                  },
                ),
              ],
            ),
          ),
          //SubButtonOne Interaction Surface (Needed Since Objects In The Overflow Of Stacks Cannot Be Interacted With)
          Positioned(
            bottom: 33 + math.sin(degreesToRadians(30)) * 60,
            left: (MediaQuery.of(context).size.width / 2) -
                24 -
                math.cos(degreesToRadians(30)) * 60,
            child: MaterialButton(
              enableFeedback: subButtonAnimationController.isCompleted,
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 0,
              height: 40,
              minWidth: 40,
              onPressed: () {
                //Only Is Enabled If Animation Cooldown Is Over & SubButton Animation Is Competed (To Prevent Spam CLick Bugs)
                if (canAnimateAgain &&
                    subButtonAnimationController.isCompleted) {
                  subButtonPressed(1);
                }
              },
            ),
          ),
          //SubButtonTwo Interaction Surface (Needed Since Objects In The Overflow Of Stacks Cannot Be Interacted With)
          Positioned(
            bottom: 33 + math.sin(degreesToRadians(90)) * 60,
            child: MaterialButton(
              enableFeedback: subButtonAnimationController.isCompleted,
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 0,
              height: 40,
              minWidth: 40,
              onPressed: () {
                //Only Is Enabled If Animation Cooldown Is Over & SubButton Animation Is Competed (To Prevent Spam CLick Bugs)
                if (canAnimateAgain &&
                    subButtonAnimationController.isCompleted) {
                  subButtonPressed(2);
                }
              },
            ),
          ),
          //SubButtonThree Interaction Surface (Needed Since Objects In The Overflow Of Stacks Cannot Be Interacted With)
          Positioned(
            bottom: 33 + math.sin(degreesToRadians(30)) * 60,
            left: (MediaQuery.of(context).size.width / 2) -
                24 +
                math.cos(degreesToRadians(30)) * 60,
            child: MaterialButton(
              enableFeedback: subButtonAnimationController.isCompleted,
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 0,
              height: 40,
              minWidth: 40,
              onPressed: () {
                //Only Is Enabled If Animation Cooldown Is Over & SubButton Animation Is Competed (To Prevent Spam CLick Bugs)
                if (canAnimateAgain &&
                    subButtonAnimationController.isCompleted) {
                  subButtonPressed(3);
                }
              },
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
                        leftGNav,
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
                        rightGNav,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //Ouputs Radians Based On Degree Input
  double degreesToRadians(double degree) {
    return degree / (180 / math.pi);
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
    Future.delayed(const Duration(milliseconds: 390), () {
      canAnimateAgain = true;
    });
  }

  //Changes Sub Button Icons To The Icons Based On Current Screen
  void updateSubButtonIcons(int index) {
    switch (index) {
      case 0:
        subButtonOneIcon = blankIcon;
        subButtonTwoIcon = blankIcon;
        subButtonThreeIcon = blankIcon;
        break;
      case 1:
        subButtonOneIcon = alarmsSubButtonOneIcon;
        subButtonTwoIcon = alarmsSubButtonTwoIcon;
        subButtonThreeIcon = alarmsSubButtonThreeIcon;
        break;
      case 2:
        subButtonOneIcon = socialSubButtonOneIcon;
        subButtonTwoIcon = socialSubButtonTwoIcon;
        subButtonThreeIcon = socialSubButtonThreeIcon;
        break;
      case 3:
        subButtonOneIcon = trackerSubButtonOneIcon;
        subButtonTwoIcon = trackerSubButtonTwoIcon;
        subButtonThreeIcon = trackerSubButtonThreeIcon;
        break;
      case 4:
        subButtonOneIcon = plannerSubButtonOneIcon;
        subButtonTwoIcon = plannerSubButtonTwoIcon;
        subButtonThreeIcon = plannerSubButtonThreeIcon;
        break;
    }
  }

  //Executes The Correct Function Based On Current Screen & SubButton Pressed
  void subButtonPressed(int subButtonNumber) {
    //Switch Case For Each Screen
    switch (_selectedIndex) {
      case 1:
        //Switch Case For Each SubButton
        switch (subButtonNumber) {
          case 1:
            alarmsScreen.buttonOneCalled();
            break;
          case 2:
            alarmsScreen.buttonTwoCalled();
            break;
          case 3:
            alarmsScreen.buttonThreeCalled();
            break;
        }
        break;
      case 2:
        //Switch Case For Each SubButton
        switch (subButtonNumber) {
          case 1:
            socialScreen.buttonOneCalled();
            break;
          case 2:
            socialScreen.buttonTwoCalled();
            break;
          case 3:
            socialScreen.buttonThreeCalled();
            break;
        }
        break;
      case 3:
        //Switch Case For Each SubButton
        switch (subButtonNumber) {
          case 1:
            trackerScreen.buttonOneCalled();
            break;
          case 2:
            trackerScreen.buttonTwoCalled();
            break;
          case 3:
            trackerScreen.buttonThreeCalled();
            break;
        }
        break;
      case 4:
        //Switch Case For Each SubButton
        switch (subButtonNumber) {
          case 1:
            plannerScreen.buttonOneCalled();
            break;
          case 2:
            plannerScreen.buttonTwoCalled();
            break;
          case 3:
            plannerScreen.buttonThreeCalled();
            break;
        }
        break;
    }
  }
}
