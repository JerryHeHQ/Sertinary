import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/common_functions.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/screens/social_screens/widgets/circular_picture.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class SocialViewUser extends StatefulWidget {
  final String userID;

  const SocialViewUser({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<SocialViewUser> createState() => _SocialViewUserState();
}

class _SocialViewUserState extends State<SocialViewUser> {
  bool dataAcquired = false;

  bool userFollowed = false;

  late ImageProvider<Object> coverPicture;
  late ImageProvider<Object> profilePicture;

  late Map<String, dynamic> userData;
  late String username;
  late String bio;
  late int numOfPosts;
  late int numOfFollowers;
  late int numOfLikes;

  getCoverPicture() async {
    final coverRef = FirebaseStorage.instance
        .ref()
        .child('CoverPictures')
        .child(widget.userID);
    try {
      await coverRef.getDownloadURL().then(
        (value) {
          coverPicture = Image.network(value).image;
        },
      );
    } on FirebaseException {
      coverPicture = const AssetImage('assets/images/Transparent.png');
    }
  }

  getProfilePicture() async {
    final profileRef = FirebaseStorage.instance
        .ref()
        .child('ProfilePictures')
        .child(widget.userID);
    try {
      await profileRef.getDownloadURL().then(
        (value) {
          profilePicture = Image.network(value).image;
        },
      );
    } on FirebaseException {
      profilePicture = const AssetImage('assets/images/DefaultPFP.png');
    }
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .get()
        .then((doc) {
      userData = doc.data() as Map<String, dynamic>;
    });

    username = await userData['username'];
    bio = await userData['bio'];
    numOfPosts = await userData['numOfPosts'];
    numOfFollowers = await userData['numOfFollowers'];
    numOfLikes = await userData['numOfLikes'];
  }

  isFollowed() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      Map userData = value.data() as Map;
      userFollowed = userData['follows'].contains(widget.userID);
    });
  }

  Future<dynamic> getData() async {
    await getCoverPicture();
    await getProfilePicture();
    await getUserData();
    await isFollowed();

    dataAcquired = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        foregroundColor: ColorConstants.monoAA,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!dataAcquired) {
              return Container(
                height: 240,
                decoration: BoxDecoration(
                  gradient: GradientConstants.gradient1,
                ),
              );
            }
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                //Default Cover
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: GradientConstants.gradient1,
                  ),
                ),
                //User Cover
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: coverPicture,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //Background
                Positioned(
                  top: 210,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      color: ColorConstants.mono10,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.mono00,
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: const Offset(1.5, -1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                //Content
                Positioned(
                  top: 210 - 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Profile Picture
                      CircularPicture(
                        height: 150,
                        width: 150,
                        image: profilePicture,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 9),
                      //Username
                      Text(
                        username,
                        style: GoogleFonts.montserrat(
                          color: ColorConstants.mono95,
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 0),
                      //Biography
                      Text(
                        bio,
                        style: GoogleFonts.montserrat(
                          color: ColorConstants.mono70,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 9),
                      //Spacer Line
                      GradientWidget(
                        gradient: GradientConstants.gradient1,
                        child: Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width - 2 * 24,
                          color: ColorConstants.mono00,
                        ),
                      ),
                      const SizedBox(height: 9),
                      //Stats
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 2 * 24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Posts
                            Column(
                              children: <Widget>[
                                Text(
                                  CommonFunctions.numFormatter(numOfPosts),
                                  style: GoogleFonts.montserrat(
                                    color: ColorConstants.mono95,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Posts',
                                  style: GoogleFonts.montserrat(
                                    color: ColorConstants.mono70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            //Followers
                            Column(
                              children: <Widget>[
                                Text(
                                  CommonFunctions.numFormatter(numOfFollowers),
                                  style: GoogleFonts.montserrat(
                                    color: ColorConstants.mono95,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Followers',
                                  style: GoogleFonts.montserrat(
                                    color: ColorConstants.mono70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            //Total Likes
                            Column(
                              children: <Widget>[
                                Text(
                                  CommonFunctions.numFormatter(numOfLikes),
                                  style: GoogleFonts.montserrat(
                                    color: ColorConstants.mono95,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Likes',
                                  style: GoogleFonts.montserrat(
                                    color: ColorConstants.mono70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      //Follow Button
                      GestureDetector(
                        onTap: () {
                          updateFollow();
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 45,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.accent50,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstants.mono00,
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset: const Offset(3, 3),
                              ),
                            ],
                            gradient: userFollowed
                                ? GradientConstants.gradient2
                                : GradientConstants.gradient1,
                          ),
                          child: Text(
                            userFollowed ? 'Unfollow' : 'Follow',
                            style: GoogleFonts.montserrat(
                              fontSize: 21,
                              color: ColorConstants.monoAA,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  updateFollow() {
    if (userFollowed) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'follows': FieldValue.arrayRemove([widget.userID])
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .update({'numOfFollowers': FieldValue.increment(-1)});
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'follows': FieldValue.arrayUnion([widget.userID])
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .update({'numOfFollowers': FieldValue.increment(1)});
    }
  }
}
