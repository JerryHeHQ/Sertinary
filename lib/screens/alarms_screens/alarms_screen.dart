import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/common_functions.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/glass_box.dart';
import 'package:sertinary/widgets/gradient_widget.dart';
import 'package:sertinary/widgets/sub_buttons/sub_buttons.dart';

class AlarmsScreen extends StatefulWidget {
  const AlarmsScreen({Key? key}) : super(key: key);

  @override
  State<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen> {
  CommonFunctions commonFunctions = CommonFunctions();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  late DocumentReference docRef;

  @override
  void initState() {
    super.initState();
    docRef = firebaseFirestore.collection('users').doc(user?.uid.toString());
  }

  void reload(String alarmsChanged) {
    setState(() {});
    if (alarmsChanged == 'true') {
      showResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/TempBackground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        FutureBuilder<dynamic>(
          future: docRef.get().then((DocumentSnapshot doc) {
            log('${user?.uid}');
            final data = doc.data() as Map<String, dynamic>;
            return data['alarms'];
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container();
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No Alarms Were Found.\nAdd Alarms Via The Sub Buttons.',
                  style: GoogleFonts.montserrat(
                    color: ColorConstants.accent50,
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            final alarmsList = snapshot.data;
            return Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemCount: alarmsList.length,
                itemBuilder: (context, index) {
                  return GlassBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
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
                    padding: const EdgeInsets.fromLTRB(12, 0, 6, 0),
                    child: GradientWidget(
                      gradient: GradientConstants.gradient1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.label,
                                    color: ColorConstants.accent50,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    alarmsList[index]['description'],
                                    style: GoogleFonts.montserrat(
                                      color: ColorConstants.accent50,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 21,
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                onChanged: (bool value) {
                                  setState(() {});
                                },
                                value: alarmsList[index]['isActive'],
                                activeColor: ColorConstants.accent50,
                                inactiveThumbColor: ColorConstants.accent50,
                              ),
                            ],
                          ),
                          Text(
                            TimeOfDay(
                              hour: alarmsList[index]['hour'].toInt(),
                              minute: alarmsList[index]['min'].toInt(),
                            ).format(context),
                            style: GoogleFonts.montserrat(
                              color: ColorConstants.accent50,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                formatDaysOfTheWeek(List<bool>.from(
                                    alarmsList[index]['daysOfTheWeek'])),
                                style: GoogleFonts.montserrat(
                                  color: ColorConstants.accent50,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  editAlarm(alarmsList[index]['id'].toDouble());
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: ColorConstants.accent50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        SubButtonLeft(onPressed: () => leftSubButton()),
        SubButtonCenter(onPressed: () => centerSubButton()),
        SubButtonRight(onPressed: () => rightSubButton()),
      ],
    );
  }

  void leftSubButton() {
    AutoRouter.of(context).push(const AlarmsCalculatorRouter());
  }

  void centerSubButton() {
    AutoRouter.of(context)
        .push(const AlarmsAddRouter())
        .then((value) => reload(value.toString()));
  }

  void editAlarm(double id) {
    AutoRouter.of(context)
        .push(AlarmsEditRouter(alarmID: id))
        .then((value) => reload(value.toString()));
  }

  void rightSubButton() {
    AutoRouter.of(context).push(const AlarmsChangeThemeRouter());
  }

  List<String> daysOfTheWeekString = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  String formatDaysOfTheWeek(List<bool> days) {
    if (days.length != 7) {
      return 'Error: Incorrect Number Of Days';
    }

    if (days[0] == true &&
        days[1] == true &&
        days[2] == true &&
        days[3] == true &&
        days[4] == true &&
        days[5] == true &&
        days[6] == true) {
      return 'Everyday';
    }

    if (days[0] == true &&
        days[1] == true &&
        days[2] == true &&
        days[3] == true &&
        days[4] == true &&
        days[5] == false &&
        days[6] == false) {
      return 'Weekdays';
    }

    if (days[0] == false &&
        days[1] == false &&
        days[2] == false &&
        days[3] == false &&
        days[4] == false &&
        days[5] == true &&
        days[6] == true) {
      return 'Weekends';
    }

    if (days[0] == false &&
        days[1] == false &&
        days[2] == false &&
        days[3] == false &&
        days[4] == false &&
        days[5] == false &&
        days[6] == false) {
      return 'No Days';
    }

    bool isFirst = true;
    String holder = '';
    for (int day = 0; day < 7; day++) {
      if (days[day] == true) {
        if (isFirst) {
          holder += daysOfTheWeekString[day];
          isFirst = false;
        } else {
          holder += ', ${daysOfTheWeekString[day]}';
        }
      }
    }

    return holder;
  }

  showResult() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConstants.mono10,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_box_outlined,
              color: ColorConstants.success,
            ),
            Text(
              ' Alarms Have Been Successfully Updated',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 13,
                  color: ColorConstants.success,
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
