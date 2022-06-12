import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/screens/social_screens/widgets/circular_picture.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class SocialMyPosts extends StatefulWidget {
  const SocialMyPosts({Key? key}) : super(key: key);

  @override
  State<SocialMyPosts> createState() => _SocialMyPostsState();
}

class _SocialMyPostsState extends State<SocialMyPosts> {
  User? user = FirebaseAuth.instance.currentUser;

  late Future<String> builderFuture;

  late Map userData;

  late ImageProvider<Object> profilePicture;

  late String username;
  late List<dynamic> postIDs;

  List<dynamic> titles = [];
  List<dynamic> likes = [];
  List<dynamic> calories = [];
  List<dynamic> carbs = [];
  List<dynamic> protein = [];
  List<dynamic> fats = [];

  late List<dynamic> postPictures;

  Future<void> getPosts() async {
    username = userData['username'];

    postIDs = userData['posts'];

    for (int i = 0; i < postIDs.length; i++) {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postIDs[i])
          .get()
          .then((value) {
        Map postData = value.data() as Map;
        titles.add(postData['title']);
        likes.add(postData['likes']);
        calories.add(postData['calories']);
        carbs.add(postData['carbs']);
        protein.add(postData['protein']);
        fats.add(postData['fats']);
      });
    }
  }

  Future<void> getPictures() async {
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

    for (int i = 0; i < postIDs.length; i++) {
      try {
        await FirebaseStorage.instance
            .ref()
            .child('PostPictures')
            .child(postIDs[i])
            .getDownloadURL()
            .then(
          (value) {
            postPictures.add(Image.network(value).image);
          },
        );
      } on FirebaseException {
        postPictures.add(const AssetImage('assets/images/Transparent.png'));
      }
    }
  }

  Future<String> initialize() async {
    postPictures = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      userData = value.data() as Map;
    });
    await getPosts();
    await getPictures();
    return Future<String>.value('start');
  }

  @override
  void initState() {
    super.initState();
    builderFuture = initialize();
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
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: ColorConstants.mono10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height - 90,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: builderFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container();
                      }
                      log('List View Build Call');
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemCount: postIDs.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.width + 120,
                            width: MediaQuery.of(context).size.width - 2 * 24,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width -
                                        2 * 12,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(6),
                                      ),
                                      color: ColorConstants.mono05,
                                      gradient: GradientConstants.gradient3,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width -
                                        2 * 12,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(6),
                                      ),
                                      color: ColorConstants.mono05,
                                      gradient: GradientConstants.gradient4,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 60,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width,
                                    width: MediaQuery.of(context).size.width -
                                        2 * 12,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: postPictures[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  left: 12 + 6,
                                  child: CircularPicture(
                                    height: 48,
                                    width: 48,
                                    image: profilePicture,
                                    onPressed: () {},
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  left: 12 + 6 + 48 + 6,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      username,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: ColorConstants.mono75,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 27,
                                  left: 12 + 6 + 48 + 6,
                                  child: Text(
                                    titles[index],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 21,
                                      color: ColorConstants.monoAA,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  right: 18,
                                  child: LikeButton(
                                    size: 30,
                                    likeCount: likes[index],
                                    isLiked: true,
                                    countBuilder: (int? count, bool isLiked,
                                        String text) {
                                      return Text(
                                        text,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                            color: isLiked
                                                ? ColorConstants.accent50
                                                : ColorConstants.mono75,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    },
                                    countPostion: CountPostion.bottom,
                                    likeBuilder: (isLiked) {
                                      return GradientWidget(
                                        gradient: isLiked
                                            ? GradientConstants.gradient1
                                            : GradientConstants.gradient3,
                                        child: Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: isLiked
                                              ? ColorConstants.accent50
                                              : ColorConstants.mono75,
                                          size: 30,
                                        ),
                                      );
                                    },
                                    onTap: (isLiked) {
                                      return Future<bool>.value(true);
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 6,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        2 * 24,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 60,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Calories',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: ColorConstants.mono75,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                calories[index].toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 21,
                                                  color: ColorConstants.monoAA,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Carbs',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: ColorConstants.mono75,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                carbs[index].toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 21,
                                                  color: ColorConstants.monoAA,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Protein',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: ColorConstants.mono75,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                protein[index].toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 21,
                                                  color: ColorConstants.monoAA,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Fats',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: ColorConstants.mono75,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                fats[index].toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 21,
                                                  color: ColorConstants.monoAA,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
