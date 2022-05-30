// ignore_for_file: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/widgets/glass_box.dart';
import 'alarm_template.dart';

class AlarmsScreen extends StatefulWidget {
  final String text;

  buttonOneCalled() => _AlarmsScreenState().buttonOneCalled();
  buttonTwoCalled() => _AlarmsScreenState().buttonTwoCalled();
  buttonThreeCalled() => _AlarmsScreenState().buttonThreeCalled();

  const AlarmsScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen>
    with AutomaticKeepAliveClientMixin<AlarmsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<AlarmTemplate> alarmsList = [
      AlarmTemplate(
        TimeOfDay.now(),
        description: "Wake Up",
        isActive: true,
        daysOfTheWeek: [true, true, true, true, true, true, true],
      ),
      AlarmTemplate(
        TimeOfDay.now(),
        description: "Get Ready",
        isActive: true,
        daysOfTheWeek: [true, true, true, true, true, true, true],
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/TempBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 0),
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
                  borderRadius: 18,
                  borderColor: Colors.black.withOpacity(0.09),
                  borderWidth: 1.5,
                  gradientColors: [
                    Colors.black.withOpacity(0.42),
                    Colors.black.withOpacity(0.27),
                  ],
                  gradientBegin: Alignment.topRight,
                  gradientEnd: Alignment.bottomLeft,
                  padding: const EdgeInsets.fromLTRB(12, 0, 6, 0),
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
                                alarmsList[index].description,
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
                            value: alarmsList[index].isActive,
                            activeColor: ColorConstants.accent50,
                            inactiveThumbColor: ColorConstants.accent50,
                          ),
                        ],
                      ),
                      Text(
                        alarmsList[index].alarmTimeOfDay.format(context),
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
                            formatDaysOfTheWeek(
                                alarmsList[index].daysOfTheWeek),
                            style: GoogleFonts.montserrat(
                              color: ColorConstants.accent50,
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              color: ColorConstants.accent50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void buttonOneCalled() {
    log("Button One Method For AlarmsScreen Was Called");
  }

  void buttonTwoCalled() {
    log("Button Two Method For AlarmsScreen Was Called");
  }

  void buttonThreeCalled() {
    log("Button Three Method For AlarmsScreen Was Called");
  }

  List<String> daysOfTheWeekString = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  String formatDaysOfTheWeek(List<bool> days) {
    if (days.length != 7) {
      return "Error: Incorrect Number Of Days";
    }

    if (days[0] == true &&
        days[1] == true &&
        days[2] == true &&
        days[3] == true &&
        days[4] == true &&
        days[5] == true &&
        days[6] == true) {
      return "Everyday";
    }

    if (days[0] == true &&
        days[1] == true &&
        days[2] == true &&
        days[3] == true &&
        days[4] == true &&
        days[5] == false &&
        days[6] == false) {
      return "Weekdays";
    }

    if (days[0] == false &&
        days[1] == false &&
        days[2] == false &&
        days[3] == false &&
        days[4] == false &&
        days[5] == true &&
        days[6] == true) {
      return "Weekends";
    }

    if (days[0] == false &&
        days[1] == false &&
        days[2] == false &&
        days[3] == false &&
        days[4] == false &&
        days[5] == false &&
        days[6] == false) {
      return "No Days";
    }

    bool isFirst = true;
    String holder = "";
    for (int day = 0; day < 7; day++) {
      if (days[day] == true) {
        if (isFirst) {
          holder += daysOfTheWeekString[day];
          isFirst = false;
        } else {
          holder += ", ${daysOfTheWeekString[day]}";
        }
      }
    }

    return holder;
  }
}
