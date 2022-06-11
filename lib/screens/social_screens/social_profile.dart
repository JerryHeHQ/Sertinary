import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/common_functions.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/screens/social_screens/widgets/circular_picture.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class SocialProfile extends StatefulWidget {
  const SocialProfile({Key? key}) : super(key: key);

  @override
  State<SocialProfile> createState() => _SocialProfileState();
}

class _SocialProfileState extends State<SocialProfile> {
  bool dataAcquired = false;

  User? user = FirebaseAuth.instance.currentUser;

  late ImageProvider<Object> coverPicture;
  late ImageProvider<Object> profilePicture;

  late Map<String, dynamic> userData;
  late String username;
  late String bio;
  late int numOfPosts;
  late int numOfFollowers;
  late int numOfLikes;

  getCoverPicture() async {
    final coverRef =
        FirebaseStorage.instance.ref().child('CoverPictures').child(user!.uid);
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
        .child(user!.uid);
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
        .doc(user!.uid)
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

  Future<dynamic> getData() async {
    await getCoverPicture();
    await getProfilePicture();
    await getUserData();

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
                      //Buttons
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 2 * 24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //Log Out Button
                            GestureDetector(
                              onTap: () {
                                log('logout pressed');
                                FirebaseAuth.instance.signOut();
                                AutoRouter.of(context)
                                    .replaceAll([const LoginRoute()]);
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
                                  gradient: GradientConstants.gradient1,
                                ),
                                child: Transform.scale(
                                  scaleX: -1.2,
                                  scaleY: 1.2,
                                  child: Icon(
                                    Icons.logout,
                                    color: ColorConstants.mono05,
                                  ),
                                ),
                              ),
                            ),
                            //Edit Profile Button
                            GestureDetector(
                              onTap: () {
                                AutoRouter.of(context)
                                    .push(const SocialEditProfileRouter())
                                    .then((value) {
                                  setState(() {});
                                });
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
                                  gradient: GradientConstants.gradient1,
                                ),
                                child: Transform.scale(
                                  scaleX: -1.2,
                                  scaleY: 1.2,
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: ColorConstants.mono05,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
}
