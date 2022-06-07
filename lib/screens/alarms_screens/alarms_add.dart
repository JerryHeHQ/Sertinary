import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/screens/alarms_screens/list_wheel_elements/am_pm_elements.dart';
import 'package:sertinary/screens/alarms_screens/list_wheel_elements/hour_elements.dart';
import 'package:sertinary/screens/alarms_screens/list_wheel_elements/minute_elements%20copy.dart';
import 'package:sertinary/widgets/glass_box.dart';

class AlarmsAdd extends StatefulWidget {
  const AlarmsAdd({Key? key}) : super(key: key);

  @override
  State<AlarmsAdd> createState() => _AlarmsAddState();
}

class _AlarmsAddState extends State<AlarmsAdd> {
  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Text Editing Controller
  final TextEditingController _descriptionController = TextEditingController();

  //Dynamically Changes TextFormField Label Color
  Color _descriptionLabelColor = ColorConstants.mono75;

  //For DayOfTheWeekButtons
  late Color selectedColorDOTWB;
  late Color unselectedColorDOTWB;
  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;

  @override
  Widget build(BuildContext context) {
    selectedColorDOTWB = ColorConstants.accent50;
    unselectedColorDOTWB = ColorConstants.mono10;

    final glassBox = GlassBox(
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
      padding: const EdgeInsets.fromLTRB(12, 0, 6, 0),
      child: Container(),
    );

    final daysOfTheWeekSelector = SizedBox(
      width: MediaQuery.of(context).size.width - 2 * 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 42,
            child: ElevatedButton(
              onPressed: () => setState(() {
                mon = !mon;
              }),
              style: ElevatedButton.styleFrom(
                primary: mon ? selectedColorDOTWB : unselectedColorDOTWB,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.monoAA,
                ),
              ),
              child: const Text('Mon'),
            ),
          ),
          SizedBox(
            width: 42,
            child: ElevatedButton(
              onPressed: () => setState(() {
                tue = !tue;
              }),
              style: ElevatedButton.styleFrom(
                primary: tue ? selectedColorDOTWB : unselectedColorDOTWB,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.monoAA,
                ),
              ),
              child: const Text('Tue'),
            ),
          ),
          SizedBox(
            width: 42,
            child: ElevatedButton(
              onPressed: () => setState(() {
                wed = !wed;
              }),
              style: ElevatedButton.styleFrom(
                primary: wed ? selectedColorDOTWB : unselectedColorDOTWB,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.monoAA,
                ),
              ),
              child: const Text('Wed'),
            ),
          ),
          SizedBox(
            width: 42,
            child: ElevatedButton(
              onPressed: () => setState(() {
                thu = !thu;
              }),
              style: ElevatedButton.styleFrom(
                primary: thu ? selectedColorDOTWB : unselectedColorDOTWB,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.monoAA,
                ),
              ),
              child: const Text('Thu'),
            ),
          ),
          SizedBox(
            width: 42,
            child: ElevatedButton(
              onPressed: () => setState(() {
                fri = !fri;
              }),
              style: ElevatedButton.styleFrom(
                primary: fri ? selectedColorDOTWB : unselectedColorDOTWB,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.monoAA,
                ),
              ),
              child: const Text('Fri'),
            ),
          ),
          SizedBox(
            width: 42,
            child: ElevatedButton(
              onPressed: () => setState(() {
                sat = !sat;
              }),
              style: ElevatedButton.styleFrom(
                primary: sat ? selectedColorDOTWB : unselectedColorDOTWB,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.monoAA,
                ),
              ),
              child: const Text('Sat'),
            ),
          ),
          SizedBox(
            width: 42,
            child: ElevatedButton(
              onPressed: () => setState(() {
                sun = !sun;
              }),
              style: ElevatedButton.styleFrom(
                primary: sun ? selectedColorDOTWB : unselectedColorDOTWB,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.monoAA,
                ),
              ),
              child: const Text('Sun'),
            ),
          ),
        ],
      ),
    );

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
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              fillColor: ColorConstants.mono10,
              filled: true,
              prefixIcon: Icon(
                Icons.text_snippet_outlined,
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
                      _descriptionController.clear();
                    },
                  );
                },
              ),
              contentPadding: const EdgeInsets.fromLTRB(18, 21, 18, 21),
              labelText: 'Description',
              labelStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: _descriptionLabelColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstants.mono15, width: 1.8),
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
                image: AssetImage('assets/images/TempBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Glass Box
          Positioned(top: 120, child: glassBox),
          //Days Of The Week Selector
          Positioned(top: 126, child: daysOfTheWeekSelector),
          Positioned(top: 267, child: timeSelectorBackground),
          //Time Selector
          Positioned(top: 138, child: timeSelector),
          //Description Field
          Positioned(top: 408, child: descriptionField),
        ],
      ),
    );
  }
}
