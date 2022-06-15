import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/screens/social_screens/widgets/circular_picture.dart';
import 'package:sertinary/widgets/search_bar.dart';

class TrackerAdd extends StatefulWidget {
  const TrackerAdd({Key? key}) : super(key: key);

  @override
  State<TrackerAdd> createState() => _TrackerAddState();
}

class _TrackerAddState extends State<TrackerAdd> {
  User? user = FirebaseAuth.instance.currentUser;

  int filterType = 0;

  List<IconData> filterIcons = [
    Icons.person_outline,
    Icons.favorite_outline,
  ];

  TextEditingController searchController = TextEditingController();

  late Future<String> builderFuture;

  late QuerySnapshot postSnapshot;

  late Map userData;

  late List<dynamic> postIDs;
  late List<dynamic> titles;
  late List<dynamic> uids;
  late List<dynamic> usernames;
  late List<dynamic> likes;

  late List<dynamic> calories;
  late List<dynamic> carbs;
  late List<dynamic> protein;
  late List<dynamic> fats;

  late List<dynamic> following;

  late List<dynamic> profilePictures;
  late List<dynamic> postPictures;

  Future<void> getPosts() async {
    postSnapshot = await FirebaseFirestore.instance.collection('posts').get();

    postIDs = postSnapshot.docs.map((doc) => doc.id).toList();
    titles = postSnapshot.docs.map((doc) => doc.get('title')).toList();
    uids = postSnapshot.docs.map((doc) => doc.get('uid')).toList();
    usernames = postSnapshot.docs.map((doc) => doc.get('username')).toList();
    likes = postSnapshot.docs.map((doc) => doc.get('likes')).toList();

    calories = postSnapshot.docs.map((doc) => doc.get('calories')).toList();
    carbs = postSnapshot.docs.map((doc) => doc.get('carbs')).toList();
    protein = postSnapshot.docs.map((doc) => doc.get('protein')).toList();
    fats = postSnapshot.docs.map((doc) => doc.get('fats')).toList();

    log('Original Post IDs: $postIDs');
    log('Original Titles: $titles');
    log('Original UIDs: $uids');
    log('Original Usernames: $usernames');
    log('Original Likes: $likes');
  }

  Future<void> filterPosts() async {
    String filter = searchController.text;
    switch (filterType) {
      case 0: //All Posts
        //If Search Terms Are Not Found In Titles And Usernames
        //Or If The Post Is Not Made By The Viewing User
        //The Post Will Not Be Shown
        for (int i = titles.length - 1; i >= 0; i--) {
          if ((!titles[i].toString().contains(filter) &&
                  !usernames[i].toString().contains(filter)) ||
              (uids[i] != user!.uid)) {
            // ignore: prefer_interpolation_to_compose_strings
            postIDs.removeAt(i);
            titles.removeAt(i);
            uids.removeAt(i);
            usernames.removeAt(i);
            likes.removeAt(i);
            calories.removeAt(i);
            carbs.removeAt(i);
            protein.removeAt(i);
            fats.removeAt(i);
          }
        }
        break;
      case 1: //Following
        //If Search Terms Are Not Found In Titles And Usernames
        //Or If The Post Is Not Saved By The Viewing User
        //The Post Will Not Be Shown
        for (int i = titles.length - 1; i >= 0; i--) {
          if ((!titles[i].toString().contains(filter) &&
                  !usernames[i].toString().contains(filter)) ||
              (!userData['saved'].contains(postIDs[i]))) {
            postIDs.removeAt(i);
            titles.removeAt(i);
            uids.removeAt(i);
            usernames.removeAt(i);
            likes.removeAt(i);
          }
        }
        break;
    }

    log('Filtered Post IDs: $postIDs');
    log('Filtered Titles: $titles');
    log('Filtered UIDs: $uids');
    log('Filtered Usernames: $usernames');
    log('Filtered Likes: $likes');
  }

  Future<void> getPictures() async {
    for (int i = 0; i < postIDs.length; i++) {
      try {
        await FirebaseStorage.instance
            .ref()
            .child('ProfilePictures')
            .child(uids[i])
            .getDownloadURL()
            .then(
          (value) {
            profilePictures.add(Image.network(value).image);
          },
        );
      } on FirebaseException {
        profilePictures.add(const AssetImage('assets/images/Transparent.png'));
      }

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
    profilePictures = [];
    postPictures = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      userData = value.data() as Map;
    });
    await getPosts();
    await filterPosts();
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorConstants.mono10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 48),
            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 12,
                    child: SearchBar(
                      textEditingController: searchController,
                      maxWidth: MediaQuery.of(context).size.width - 84,
                      suffixPressed: () async {
                        log('Filter Button Pressed');
                        builderFuture = initialize();
                        setState(() {});
                      },
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        gradient: GradientConstants.gradient1,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.mono00,
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          filterIcons[filterType],
                          color: ColorConstants.mono00,
                        ),
                        onPressed: () {
                          filterType = (filterType + 1) % 2;
                          builderFuture = initialize();
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
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
                                width:
                                    MediaQuery.of(context).size.width - 2 * 12,
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
                                width:
                                    MediaQuery.of(context).size.width - 2 * 12,
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
                                width:
                                    MediaQuery.of(context).size.width - 2 * 12,
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
                                image: profilePictures[index],
                                onPressed: () {
                                  AutoRouter.of(context).push(
                                    SocialViewUserRouter(
                                      userID: uids[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 6,
                              left: 12 + 6 + 48 + 6,
                              child: GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).push(
                                    SocialViewUserRouter(
                                      userID: uids[index],
                                    ),
                                  );
                                },
                                child: Text(
                                  usernames[index],
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
                              child: GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).push(
                                    SocialViewPostRouter(
                                      postID: postIDs[index],
                                    ),
                                  );
                                },
                                child: Text(
                                  titles[index],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 21,
                                    color: ColorConstants.monoAA,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 3,
                              right: 18,
                              child: IconButton(
                                icon: Icon(Icons.add,
                                    color: ColorConstants.monoAA, size: 36),
                                onPressed: () {
                                  addFood(index);
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 6,
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width - 2 * 24,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }

  addFood(int i) {
    log(postIDs[i]);

    FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'food': FieldValue.arrayUnion([postIDs[i]])
    });
  }
}
