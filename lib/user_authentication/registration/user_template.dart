class UserTemplate {
  String uid;
  String email;
  String username;

  UserTemplate({
    required this.uid,
    required this.email,
    required this.username,
  });

  //Send Data To Firebase Server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': '',
      'numOfPosts': 0,
      'numOfFollowers': 0,
      'numOfLikes': 0,
      'nextAlarmID': 0,
      'alarms': [],
      'posts': [],
      'saved': [],
      'follows': [],
    };
  }
}
