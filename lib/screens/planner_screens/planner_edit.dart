import 'package:flutter/material.dart';

class PlannerEdit extends StatefulWidget {
  const PlannerEdit({Key? key, required this.date, required this.eventID})
      : super(key: key);

  final DateTime date;
  final int eventID;

  @override
  State<PlannerEdit> createState() => _PlannerEditState();
}

class _PlannerEditState extends State<PlannerEdit> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
