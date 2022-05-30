import 'package:flutter/material.dart';

class AlarmTemplate {
  TimeOfDay alarmTimeOfDay;
  String description;
  bool isActive;
  List<bool> daysOfTheWeek;

  AlarmTemplate(
    this.alarmTimeOfDay, {
    required this.description,
    required this.isActive,
    required this.daysOfTheWeek,
  });
}
