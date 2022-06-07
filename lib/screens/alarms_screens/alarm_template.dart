class AlarmTemplate {
  double id;
  double hour;
  double min;
  String description;
  bool isActive;
  List<bool> daysOfTheWeek;

  AlarmTemplate({
    required this.id,
    required this.hour,
    required this.min,
    required this.description,
    required this.isActive,
    required this.daysOfTheWeek,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hour': hour,
      'min': min,
      'weight': hour * 60 + min,
      'description': description,
      'isActive': isActive,
      'daysOfTheWeek': daysOfTheWeek,
    };
  }
}
