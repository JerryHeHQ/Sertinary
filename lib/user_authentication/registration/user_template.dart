class UserTemplate {
  String? uid;
  String? username;
  String? email;
  String? password;

  UserTemplate({this.uid, this.username, this.email, this.password});

  //Receive Data From Firebase Server
  factory UserTemplate.fromMap(map) {
    return UserTemplate(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
    );
  }

  //Send Data To Firebase Server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }
}
