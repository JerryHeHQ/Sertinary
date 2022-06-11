import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/screens/alarms_screens/alarm_template.dart';
import 'package:sertinary/screens/alarms_screens/widgets/am_pm_elements.dart';
import 'package:sertinary/screens/alarms_screens/widgets/day_of_the_week_button.dart';
import 'package:sertinary/screens/alarms_screens/widgets/hour_elements.dart';
import 'package:sertinary/screens/alarms_screens/widgets/minute_elements.dart';
import 'package:sertinary/widgets/glass_box.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class AlarmsAdd extends StatefulWidget {
  const AlarmsAdd({Key? key}) : super(key: key);

  @override
  State<AlarmsAdd> createState() => _AlarmsAddState();
}

class _AlarmsAddState extends State<AlarmsAdd> {
  //Text Editing Controller
  final TextEditingController _descriptionController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _descriptionLabelColor = ColorConstants.mono75;

  //DayOfTheWeekButtons
  List<bool> theDOTW = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  updateDOTWB(int day) {
    theDOTW[day] = !theDOTW[day];
    setState(() {});
  }

  //List Wheel Time Selector Controllers
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _ampmController;

  late FirebaseFirestore firebaseFirestore;
  User? user;
  late Map<String, dynamic> data;
  late List<dynamic> alarmsList;

  @override
  void initState() {
    super.initState();

    firebaseFirestore = FirebaseFirestore.instance;
    user = FirebaseAuth.instance.currentUser;

    _hourController = FixedExtentScrollController();
    _minuteController = FixedExtentScrollController();
    _ampmController = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final glassBox = GlassBox(
      width: MediaQuery.of(context).size.width - 2 * 12,
      height: 429,
      blur: 3,
      borderRadius: 6,
      borderColor: Colors.black.withOpacity(0.09),
      borderWidth: 1.5,
      gradientColors: [
        Colors.black.withOpacity(0.9),
        Colors.black.withOpacity(0.6),
      ],
      gradientBegin: Alignment.topLeft,
      gradientEnd: Alignment.bottomRight,
      padding: const EdgeInsets.all(0),
      child: Container(),
    );

    final daysOfTheWeekSelector = SizedBox(
      width: MediaQuery.of(context).size.width - 2 * 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DOTWButton(on: theDOTW[0], day: 'Mon', onTap: () => updateDOTWB(0)),
          DOTWButton(on: theDOTW[1], day: 'Tue', onTap: () => updateDOTWB(1)),
          DOTWButton(on: theDOTW[2], day: 'Wed', onTap: () => updateDOTWB(2)),
          DOTWButton(on: theDOTW[3], day: 'Thu', onTap: () => updateDOTWB(3)),
          DOTWButton(on: theDOTW[4], day: 'Fri', onTap: () => updateDOTWB(4)),
          DOTWButton(on: theDOTW[5], day: 'Sat', onTap: () => updateDOTWB(5)),
          DOTWButton(on: theDOTW[6], day: 'Sun', onTap: () => updateDOTWB(6)),
        ],
      ),
    );

    final timeSelectorBackground = GradientWidget(
      gradient: GradientConstants.gradient1,
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width - 2 * 36,
        decoration: BoxDecoration(
          color: ColorConstants.mono10,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    );

    final timeSelector = SizedBox(
      height: 300,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 66,
                child: ListWheelScrollView.useDelegate(
                  controller: _hourController,
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
                  controller: _minuteController,
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
                  controller: _ampmController,
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

    final descriptionField = SizedBox(
      width: MediaQuery.of(context).size.width - 2 * 24,
      child: Container(
        alignment: Alignment.centerRight,
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() => _descriptionLabelColor =
                hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
          },
          child: TextFormField(
            autofocus: false,
            controller: _descriptionController,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              _descriptionController.text = value!;
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
                  Icons.text_snippet_outlined,
                  color: ColorConstants.accent50,
                ),
              ),
              suffixIcon: GradientWidget(
                gradient: GradientConstants.gradient1,
                child: IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: ColorConstants.accent50,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _descriptionController.clear();
                      },
                    );
                  },
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
              labelText: 'Description',
              labelStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: _descriptionLabelColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstants.mono15, width: 1.8),
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
      ),
    );

    final addButton = Container(
      alignment: Alignment.centerRight,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: BoxDecoration(
            gradient: GradientConstants.gradient1,
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
            onPressed: () {
              getData();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 15),
                Text(
                  'Add Alarm',
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        foregroundColor: ColorConstants.monoAA,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          //Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/TempBackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Glass Box
          Positioned(top: 90, child: glassBox),
          //Time Selector
          Positioned(top: 237, child: timeSelectorBackground),
          Positioned(top: 108, child: timeSelector),
          //Days Of The Week Selector
          Positioned(top: 102, child: daysOfTheWeekSelector),
          //Description Field
          Positioned(top: 378, child: descriptionField),
          //Add Alarm Button
          Positioned(top: 450, right: 24, child: addButton),
        ],
      ),
    );
  }

  getData() async {
    final docRef =
        firebaseFirestore.collection('users').doc(user?.uid.toString());
    docRef.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
        alarmsList = data['alarms'] ?? [];
        addAlarm();
      },
    );
  }

  addAlarm() async {
    double hour = (_hourController.selectedItem + 1) % 12;
    double min = _minuteController.selectedItem % 60;
    bool am = _ampmController.selectedItem == 0;

    if (!am) {
      hour += 12;
    }

    double nextAlarmID = data['nextAlarmID'].toDouble();

    AlarmTemplate alarm = AlarmTemplate(
      id: nextAlarmID,
      hour: hour,
      min: min,
      description: _descriptionController.text,
      isActive: true,
      daysOfTheWeek: theDOTW,
    );

    alarmsList.add(alarm.toMap());

    for (int i = 0; i < alarmsList.length - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < alarmsList.length; j++) {
        if (alarmsList[j]['weight'] < alarmsList[minIndex]['weight']) {
          minIndex = j;
        }
      }

      Map<String, dynamic> temp = alarmsList[minIndex];
      alarmsList[minIndex] = alarmsList[i];
      alarmsList[i] = temp;
    }

    updateFirebase();
  }

  updateFirebase() {
    bool errorOccurred = false;
    firebaseFirestore.collection('users').doc(user!.uid.toString()).update({
      'alarms': FieldValue.delete(),
    }).then((value) {
      firebaseFirestore
          .collection('users')
          .doc(user?.uid.toString())
          .set({'alarms': alarmsList}, SetOptions(merge: true));
    }).then((value) {
      firebaseFirestore
          .collection('users')
          .doc(user?.uid.toString())
          .update({'nextAlarmID': FieldValue.increment(1)});
    }).onError((error, stackTrace) {
      errorOccurred = true;
    }).then((value) {
      showResult(errorOccurred);
    });
  }

  showResult(bool errorOccurred) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConstants.mono10,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              errorOccurred
                  ? Icons.error_outline_rounded
                  : Icons.add_alarm_outlined,
              color:
                  errorOccurred ? ColorConstants.fail : ColorConstants.success,
            ),
            Text(
              errorOccurred
                  ? ' An Error Occured When Adding The Alarm'
                  : ' Alarm Has Been Successfully Added',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 13,
                  color: errorOccurred
                      ? ColorConstants.fail
                      : ColorConstants.success,
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
