import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/screens/alarms_screens/widgets/am_pm_elements.dart';
import 'package:sertinary/screens/alarms_screens/widgets/hour_elements.dart';
import 'package:sertinary/screens/alarms_screens/widgets/minute_elements.dart';
import 'package:sertinary/screens/alarms_screens/widgets/sleep_rec_box.dart';
import 'package:sertinary/widgets/glass_box.dart';

class AlarmsCalculator extends StatefulWidget {
  const AlarmsCalculator({Key? key}) : super(key: key);

  @override
  State<AlarmsCalculator> createState() => _AlarmsCalculatorState();
}

class _AlarmsCalculatorState extends State<AlarmsCalculator> {
  //List Wheel Time Selector Controllers
  FixedExtentScrollController hourController =
      FixedExtentScrollController(initialItem: -1);
  FixedExtentScrollController minuteController = FixedExtentScrollController();
  FixedExtentScrollController ampmController = FixedExtentScrollController();

  //Form Key
  final formKey = GlobalKey<FormState>();

  //Text Editing Controller
  TextEditingController fallAsleepController = TextEditingController();
  //Text Editing Controller
  TextEditingController sleepCycleController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color fallAsleeplabelColor = ColorConstants.mono75;
  Color sleepCyclelabelColor = ColorConstants.mono75;

  //Show Recommended Or Not
  bool showRecommended = false;

  //User Input Holders
  int selectedHour = 0;
  int selectedMin = 0;
  int timeToFallAsleep = 0;
  int timePerSleepCycle = 0;

  //Used For Calculating Recommended
  List<int> sleepCycles = [0, 0, 0];
  List<int> sleepTimeHour = [0, 0, 0];
  List<int> sleepTimeMin = [0, 0, 0];
  List<int> hoursSlept = [0, 0, 0];
  List<int> minsSlept = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    //Background Glass Box
    final backgroundBox = GlassBox(
      width: MediaQuery.of(context).size.width - 2 * 12,
      height: 420,
      blur: 3,
      borderRadius: 18,
      borderColor: Colors.black.withOpacity(0.09),
      borderWidth: 1.5,
      gradientColors: [
        Colors.black.withOpacity(0.42),
        Colors.black.withOpacity(0.27),
      ],
      gradientBegin: Alignment.topRight,
      gradientEnd: Alignment.bottomLeft,
      padding: const EdgeInsets.all(0),
      child: Container(),
    );

    //Instructions
    final instructions = Text(
      'Enter Your Wake Up Time:',
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 24,
          color: ColorConstants.accent50,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    //Background For List Wheel Time Selector
    final timeSelectorBackground = Container(
      height: 48,
      width: MediaQuery.of(context).size.width - 2 * 36,
      decoration: BoxDecoration(
        color: ColorConstants.mono10,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
      ),
    );

    //List Wheel Time Selector
    final timeSelector = SizedBox(
      height: 300,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.mono20,
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 66,
                child: ListWheelScrollView.useDelegate(
                  controller: hourController,
                  onSelectedItemChanged: (i) => runUpdate(),
                  itemExtent: 51,
                  perspective: 0.006,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      12,
                      (index) => HourElements(
                        hours: (index + 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              SizedBox(
                width: 66,
                child: ListWheelScrollView.useDelegate(
                  controller: minuteController,
                  onSelectedItemChanged: (i) => runUpdate(),
                  itemExtent: 51,
                  perspective: 0.006,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      60,
                      (index) => MinuteElements(
                        mins: (index),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18 + 9),
              SizedBox(
                width: 66,
                child: ListWheelScrollView.useDelegate(
                  controller: ampmController,
                  onSelectedItemChanged: (i) => runUpdate(),
                  itemExtent: 51,
                  perspective: 0.006,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 2,
                    builder: (context, index) {
                      return AMPMElements(
                        index: (index),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    //FallAsleep Form Field
    final fallAsleepField = Container(
      width: MediaQuery.of(context).size.width - 2 * 24,
      alignment: Alignment.centerRight,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() => fallAsleeplabelColor =
              hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
        },
        child: TextFormField(
          autofocus: false,
          controller: fallAsleepController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onSaved: (value) {
            fallAsleepController.text = value!;
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
              Icons.more_time_outlined,
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
                    fallAsleepController.clear();
                  },
                );
              },
            ),
            contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
            labelText: 'Time To Fall Asleep',
            labelStyle: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
                color: fallAsleeplabelColor,
                fontWeight: FontWeight.w600,
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

    //Username Form Field
    final sleepCycleField = Container(
      width: MediaQuery.of(context).size.width - 2 * 24,
      alignment: Alignment.centerRight,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() => sleepCyclelabelColor =
              hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
        },
        child: TextFormField(
          autofocus: false,
          controller: sleepCycleController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onSaved: (value) {
            sleepCycleController.text = value!;
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
              Icons.bed_outlined,
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
                    sleepCycleController.clear();
                  },
                );
              },
            ),
            contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
            labelText: 'Time Per Sleep Cycle',
            labelStyle: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
                color: sleepCyclelabelColor,
                fontWeight: FontWeight.w600,
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

    //Recommended Glass Box
    final recommendedBox0 = SleepRecommendedBox(
      sleepTimeHour: sleepTimeHour[0],
      sleepTimeMin: sleepTimeMin[0],
      sleepCycles: sleepCycles[0],
      hoursSlept: hoursSlept[0],
      minsSlept: minsSlept[0],
    );
    final recommendedBox1 = SleepRecommendedBox(
      sleepTimeHour: sleepTimeHour[1],
      sleepTimeMin: sleepTimeMin[1],
      sleepCycles: sleepCycles[1],
      hoursSlept: hoursSlept[1],
      minsSlept: minsSlept[1],
    );
    final recommendedBox2 = SleepRecommendedBox(
      sleepTimeHour: sleepTimeHour[2],
      sleepTimeMin: sleepTimeMin[2],
      sleepCycles: sleepCycles[2],
      hoursSlept: hoursSlept[2],
      minsSlept: minsSlept[2],
    );

    //List Of Recommended
    final recommeded = Visibility(
      visible: showRecommended,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 2 * 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            recommendedBox0,
            recommendedBox1,
            recommendedBox2,
          ],
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        foregroundColor: ColorConstants.monoAA,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/TempBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formKey,
          onChanged: () => runUpdate(),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(top: 90, child: backgroundBox),
              Positioned(top: 102, left: 24, child: instructions),
              Positioned(top: 225, child: timeSelectorBackground),
              Positioned(top: 96, child: timeSelector),
              Positioned(top: 360, child: fallAsleepField),
              Positioned(top: 432, child: sleepCycleField),
              Positioned(top: 522, child: recommeded),
            ],
          ),
        ),
      ),
    );
  }

  runUpdate() {
    if (fallAsleepController.text.isNotEmpty &&
        sleepCycleController.text.isNotEmpty) {
      log('update was called');
      updateRecommended();
    } else {
      showRecommended = false;
    }
  }

  updateRecommended() {
    updateUserInputs();
    updateCycles();
    updateTimeSlept();
    updateSleepTime();

    setState(() {
      showRecommended = true;
    });
  }

  updateUserInputs() {
    int hour = (hourController.selectedItem + 1) % 12;
    bool am = ampmController.selectedItem == 0;

    if (!am) {
      hour += 12;
    }

    selectedHour = hour;
    selectedMin = minuteController.selectedItem % 60;

    timeToFallAsleep = int.parse(fallAsleepController.text);
    timePerSleepCycle = int.parse(sleepCycleController.text);
  }

  updateCycles() {
    if (timePerSleepCycle >= 420) {
      sleepCycles[0] = 1;
      sleepCycles[1] = 2;
      sleepCycles[2] = 3;
    } else {
      sleepCycles[1] = (420 / timePerSleepCycle).ceil();
      sleepCycles[0] = sleepCycles[1] + 1;
      sleepCycles[2] = sleepCycles[1] - 1;
    }
  }

  updateTimeSlept() {
    for (int i = 0; i < 3; i++) {
      int totalMinsSlept = sleepCycles[i] * timePerSleepCycle;

      hoursSlept[i] = (totalMinsSlept / 60).floor();
      minsSlept[i] = totalMinsSlept % 60;
    }
  }

  updateSleepTime() {
    int selectedValue = selectedHour * 60 + selectedMin;
    for (int i = 0; i < 3; i++) {
      int sleptValue = hoursSlept[i] * 60 + minsSlept[i];

      int timeDifference = selectedValue - sleptValue - timeToFallAsleep;

      int timeValue = timeDifference;

      if (timeDifference < 0) {
        timeDifference = -1 * timeDifference;
        timeDifference = timeDifference % 1440;
        timeValue = 1440 - timeDifference;
      }

      sleepTimeHour[i] = (timeValue / 60).floor();
      sleepTimeMin[i] = timeValue % 60;
    }

    log(selectedHour.toString());
  }
}
