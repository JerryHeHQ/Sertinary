import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/widgets/gradient_widget.dart';
import 'package:sertinary/widgets/sub_buttons/sub_buttons.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  int totalCalories = 2000;
  int currentCalories = 0;
  int totalCarbs = 145;
  int currentCarbs = 0;
  int totalProtein = 175;
  int currentProtein = 0;
  int totalFats = 80;
  int currentFats = 0;

  List<dynamic> foodIDs = [];
  List<dynamic> calories = [];
  List<dynamic> carbs = [];
  List<dynamic> protein = [];
  List<dynamic> fats = [];
  List<dynamic> images = [];

  late Future<String> startBuild;

  Future<void> getFoodIDs() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then(
      (value) {
        foodIDs = value['food'];
      },
    );
    log(foodIDs.toString());
  }

  Future<void> getFoodData() async {
    for (String food in foodIDs) {
      await FirebaseFirestore.instance.collection('posts').doc(food).get().then(
        (value) async {
          calories.add(value['calories']);
          carbs.add(value['carbs']);
          protein.add(value['protein']);
          fats.add(value['fats']);
          try {
            await FirebaseStorage.instance
                .ref()
                .child('PostPictures')
                .child(food)
                .getDownloadURL()
                .then(
              (value) {
                images.add(Image.network(value).image);
              },
            );
          } on FirebaseException {
            images.add(
              const AssetImage('assets/images/Transparent.png'),
            );
          }
        },
      );
    }
  }

  currentTotals() {
    //Get Sums
    currentCalories = calories.reduce((a, b) => a + b);
    currentCarbs = carbs.reduce((a, b) => a + b);
    currentProtein = protein.reduce((a, b) => a + b);
    currentFats = fats.reduce((a, b) => a + b);
  }

  Future<String> initialize() async {
    await getFoodIDs();
    await getFoodData();
    if (foodIDs.isNotEmpty) {
      currentTotals();
    }
    return Future<String>.value('start');
  }

  @override
  void initState() {
    super.initState();
    startBuild = initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ColorConstants.mono10,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FutureBuilder(
            future: startBuild,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              }
              return Column(
                children: <Widget>[
                  const SizedBox(height: 12),
                  Text(
                    DateFormat('EEEE: MMMM d, y').format(DateTime.now()),
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      color: ColorConstants.monoAA,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Calories',
                        style: GoogleFonts.montserrat(
                          fontSize: 21,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${currentCalories.toString()}/${totalCalories.toString()}',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      GradientWidget(
                        gradient: GradientConstants.gradient5,
                        child: Container(
                          height: 6,
                          color: ColorConstants.mono00,
                        ),
                      ),
                      GradientWidget(
                        gradient: (currentCalories <= totalCalories)
                            ? GradientConstants.gradient1
                            : GradientConstants.gradient6,
                        child: Container(
                          height: 6,
                          width: (currentCalories <= totalCalories)
                              ? (MediaQuery.of(context).size.width - 2 * 12) *
                                  (currentCalories / totalCalories)
                              : null,
                          color: ColorConstants.mono00,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Carbs (g)',
                        style: GoogleFonts.montserrat(
                          fontSize: 21,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${currentCarbs.toString()}/${totalCarbs.toString()}',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      GradientWidget(
                        gradient: GradientConstants.gradient5,
                        child: Container(
                          height: 6,
                          color: ColorConstants.mono00,
                        ),
                      ),
                      GradientWidget(
                        gradient: (currentCarbs <= totalCarbs)
                            ? GradientConstants.gradient1
                            : GradientConstants.gradient6,
                        child: Container(
                          height: 6,
                          width: (currentCarbs <= totalCarbs)
                              ? (MediaQuery.of(context).size.width - 2 * 12) *
                                  (currentCarbs / totalCarbs)
                              : null,
                          color: ColorConstants.mono00,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Protein (g)',
                        style: GoogleFonts.montserrat(
                          fontSize: 21,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${currentProtein.toString()}/${totalProtein.toString()}',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      GradientWidget(
                        gradient: GradientConstants.gradient5,
                        child: Container(
                          height: 6,
                          color: ColorConstants.mono00,
                        ),
                      ),
                      GradientWidget(
                        gradient: (currentProtein <= totalProtein)
                            ? GradientConstants.gradient1
                            : GradientConstants.gradient6,
                        child: Container(
                          height: 6,
                          width: (currentProtein <= totalProtein)
                              ? (MediaQuery.of(context).size.width - 2 * 12) *
                                  (currentProtein / totalProtein)
                              : null,
                          color: ColorConstants.mono00,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Fats (g)',
                        style: GoogleFonts.montserrat(
                          fontSize: 21,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${currentFats.toString()}/${totalFats.toString()}',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: ColorConstants.monoAA,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      GradientWidget(
                        gradient: GradientConstants.gradient5,
                        child: Container(
                          height: 6,
                          color: ColorConstants.mono00,
                        ),
                      ),
                      GradientWidget(
                        gradient: (currentFats <= totalFats)
                            ? GradientConstants.gradient1
                            : GradientConstants.gradient6,
                        child: Container(
                          height: 6,
                          width: (currentFats <= totalFats)
                              ? (MediaQuery.of(context).size.width - 2 * 12) *
                                  (currentFats / totalFats)
                              : null,
                          color: ColorConstants.mono00,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 540,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: foodIDs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: ColorConstants.mono00,
                            gradient: GradientConstants.gradient3,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: images[index],
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${calories[index]} Calories',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: ColorConstants.monoAA,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${carbs[index]} Carbs (g)',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: ColorConstants.monoAA,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${protein[index]} Protein (g)',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: ColorConstants.monoAA,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${fats[index]} Fats (g)',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: ColorConstants.monoAA,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
        SubButtonLeft(onPressed: () => leftSubButton()),
        SubButtonCenter(onPressed: () => centerSubButton()),
        SubButtonRight(onPressed: () => rightSubButton()),
      ],
    );
  }

  void leftSubButton() {
    AutoRouter.of(context).push(const TrackerOverviewRouter());
  }

  void centerSubButton() {
    AutoRouter.of(context).push(const TrackerAddRouter()).then((value) async {
      await initialize();
      setState(() {});
    });
  }

  void rightSubButton() {
    AutoRouter.of(context).push(const TrackerChangeDateRouter());
  }
}
