import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexagon/hexagon.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({Key? key}) : super(key: key);

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController timerController;
  late Animation<double> timerAnimation;

  math.Random random = math.Random();

  late String equation;
  late int answer;
  List<int> numbers = [];

  int correct = 2;
  int numberCorrect = 0;

  int duration = 30;

  getEquation() {
    answer = 0;
    late int x;
    late int y;
    late int z;

    while ((answer).abs() < 50) {
      x = random.nextInt(1001) - 500;
      y = random.nextInt(1001) - 500;
      z = random.nextInt(1001) - 500;
      answer = x + y + z;
    }

    String strX = '$x';
    String strY = '$y';
    String strZ = '$z';

    if (y > 0) {
      strY = '+$y';
    }
    if (z > 0) {
      strZ = '+$z';
    }

    equation = strX + strY + strZ;
  }

  getNumbers() {
    for (int i = 0; i <= 36; i++) {
      numbers.add(random.nextInt(3001) - 1500);
    }
    if (!numbers.contains(answer)) {
      numbers[random.nextInt(37)] = answer;
    }
  }

  @override
  void initState() {
    super.initState();

    getEquation();

    getNumbers();

    timerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );

    timerAnimation = CurvedAnimation(
      parent: timerController,
      curve: Curves.linear,
    );

    timerController.addListener(() {
      setState(() {});
      if (timerController.isCompleted) {
        correct = 0;
        numberCorrect = 0;
        numbers = [];
        getEquation();
        getNumbers();
        timerController.reset();

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    timerController.forward();

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ColorConstants.mono10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Container(
                    height: 12,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: GradientConstants.gradient2,
                    ),
                  ),
                  Container(
                    height: 12,
                    width: MediaQuery.of(context).size.width *
                        (1 - timerAnimation.value),
                    decoration: BoxDecoration(
                      gradient: GradientConstants.gradient1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 90),
              Text(
                equation,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 51,
                    color: ColorConstants.monoAA,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height / 2) - 360),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: HexagonGrid.pointy(
                  width: MediaQuery.of(context).size.width - 12,
                  depth: 3,
                  buildTile: (coordinates) => HexagonWidgetBuilder(
                    color: ColorConstants.accent50,
                    padding: 1.8,
                    cornerRadius: 3.0,
                    child: GestureDetector(
                      child: SizedBox(
                        height: 39,
                        width: 39,
                        child: Center(
                          child: Text(
                            '${numbers[getIndex(coordinates.q, coordinates.r)]}',
                          ),
                        ),
                      ),
                      onTap: () {
                        checkAnswer(getIndex(coordinates.q, coordinates.r));
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Icon(
                getIcon(),
                color: (correct == 0)
                    ? ColorConstants.fail
                    : ColorConstants.success,
                size: 48,
              ),
              Text(
                '$numberCorrect/3',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: ColorConstants.monoAA,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // SubButtonLeft(onPressed: () => leftSubButton()),
        // SubButtonCenter(onPressed: () => centerSubButton()),
        // SubButtonRight(onPressed: () => rightSubButton()),
      ],
    );
  }

  checkAnswer(int i) {
    if (numbers[i] == answer) {
      correct = 1;
      numberCorrect++;
    } else {
      correct = 0;
      numberCorrect = 0;
    }

    numbers = [];
    getEquation();
    getNumbers();
    timerController.reset();

    setState(() {});
  }

  IconData? getIcon() {
    if (correct == 0) {
      return Icons.clear;
    } else if (correct == 1) {
      return Icons.check;
    } else {
      return null;
    }
  }

  //Really Inefficient, But This Is Just A Test Build
  int getIndex(int q, int r) {
    switch (q) {
      case -3:
        switch (r) {
          case 0:
            return 15;
          case 1:
            return 22;
          case 2:
            return 28;
          case 3:
            return 33;
        }
        break;
      case -2:
        switch (r) {
          case -1:
            return 9;
          case 0:
            return 16;
          case 1:
            return 23;
          case 2:
            return 29;
          case 3:
            return 34;
        }
        break;
      case -1:
        switch (r) {
          case -2:
            return 4;
          case -1:
            return 10;
          case 0:
            return 17;
          case 1:
            return 24;
          case 2:
            return 30;
          case 3:
            return 35;
        }
        break;
      case 0:
        switch (r) {
          case -3:
            return 0;
          case -2:
            return 5;
          case -1:
            return 11;
          case 0:
            return 18;
          case 1:
            return 25;
          case 2:
            return 31;
          case 3:
            return 36;
        }
        break;
      case 1:
        switch (r) {
          case -3:
            return 1;
          case -2:
            return 6;
          case -1:
            return 12;
          case 0:
            return 19;
          case 1:
            return 26;
          case 2:
            return 32;
        }
        break;
      case 2:
        switch (r) {
          case -3:
            return 2;
          case -2:
            return 7;
          case -1:
            return 13;
          case 0:
            return 20;
          case 1:
            return 27;
        }
        break;
      case 3:
        switch (r) {
          case -3:
            return 3;
          case -2:
            return 8;
          case -1:
            return 14;
          case 0:
            return 21;
        }
        break;
    }
    return 38;
  }

  // void leftSubButton() {
  //   AutoRouter.of(context).push(const PlannerWorkRythmnRouter());
  // }

  // void centerSubButton() {
  //   AutoRouter.of(context).push(const PlannerAddRouter());
  // }

  // void rightSubButton() {
  //   AutoRouter.of(context).push(const PlannerChangeDateRouter());
  // }
}
