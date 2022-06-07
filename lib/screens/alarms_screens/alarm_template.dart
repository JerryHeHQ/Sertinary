class AlarmTemplate {
  int hour;
  int min;
  String description;
  bool isActive;
  List<bool> daysOfTheWeek;

  AlarmTemplate({
    required this.hour,
    required this.min,
    required this.description,
    required this.isActive,
    required this.daysOfTheWeek,
  });

  Map<String, dynamic> toMap() {
    return {
      'hour': hour,
      'min': min,
      'description': description,
      'isActive': isActive,
      'daysOfTheWeek': daysOfTheWeek,
    };
  }
}
