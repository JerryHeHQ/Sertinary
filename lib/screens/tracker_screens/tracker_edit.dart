import 'package:flutter/material.dart';

class TrackerEdit extends StatefulWidget {
  const TrackerEdit({Key? key, required this.date, required this.mealID})
      : super(key: key);

  final DateTime date;
  final int mealID;

  @override
  State<TrackerEdit> createState() => _TrackerEditState();
}

class _TrackerEditState extends State<TrackerEdit> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
