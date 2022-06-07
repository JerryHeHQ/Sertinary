import 'package:sertinary/screens/alarms_screens/alarm_template.dart';

class UserTemplate {
  String uid;
  String username;
  String email;
  String? password;

  List<AlarmTemplate> alarmsList;

  UserTemplate({
    required this.uid,
    required this.username,
    required this.email,
    this.password,
    required this.alarmsList,
  });

  //Send Data To Firebase Server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'alarms': alarmsList,
    };
  }
}
