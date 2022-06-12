import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/routes/router.gr.dart';
import 'package:sertinary/screens/social_screens/widgets/circular_picture.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class SocialViewPost extends StatefulWidget {
  final String postID;

  const SocialViewPost({Key? key, required this.postID}) : super(key: key);

  @override
  State<SocialViewPost> createState() => _SocialPostState();
}

class _SocialPostState extends State<SocialViewPost> {
  User? user = FirebaseAuth.instance.currentUser;

  late Future<String> builderFuture;

  late Map userData;
  late Map postData;

  late String uid;
  late String username;
  late String title;
  late int likes;
  late String calories;
  late String carbs;
  late String protein;
  late String fats;
  late String ingredients;
  late String instructions;
  late bool liked;

  late ImageProvider<Object> profilePicture;
  late ImageProvider<Object> postPicture;

  Future<void> getPostData() async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postID)
        .get()
        .then((value) {
      postData = value.data() as Map;
    });

    uid = postData['uid'];
    username = postData['username'];
    title = postData['title'];
    likes = postData['likes'];
    calories = postData['calories'].toString();
    carbs = postData['carbs'].toString();
    protein = postData['protein'].toString();
    fats = postData['fats'].toString();
    ingredients = postData['ingredients'];
    instructions = postData['instructions'];

    if (userData['saved'].contains(widget.postID)) {
      liked = true;
    } else {
      liked = false;
    }
  }

  Future<void> getPictures() async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('ProfilePictures')
          .child(uid)
          .getDownloadURL()
          .then(
        (value) {
          profilePicture = Image.network(value).image;
        },
      );
    } on FirebaseException {
      profilePicture = const AssetImage('assets/images/Transparent.png');
    }

    try {
      await FirebaseStorage.instance
          .ref()
          .child('PostPictures')
          .child(widget.postID)
          .getDownloadURL()
          .then(
        (value) {
          postPicture = Image.network(value).image;
        },
      );
    } on FirebaseException {
      postPicture = const AssetImage('assets/images/Transparent.png');
    }
  }

  Future<String> initialize() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      userData = value.data() as Map;
    });
    await getPostData();
    await getPictures();
    return 'start';
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
        padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
        color: ColorConstants.mono10,
        child: FutureBuilder(
          future: builderFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container();
            }
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 2 * 12,
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
                  top: MediaQuery.of(context).size.width + 60,
                  child: Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width - 2 * 12,
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
                    width: MediaQuery.of(context).size.width - 2 * 12,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: postPicture,
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
                    onPressed: () {
                      AutoRouter.of(context).push(
                        SocialViewUserRouter(
                          userID: uid,
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
                          userID: uid,
                        ),
                      );
                    },
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
                    title,
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
                    likeCount: likes,
                    isLiked: liked,
                    countBuilder: (int? count, bool isLiked, String text) {
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
                          isLiked ? Icons.favorite : Icons.favorite_outline,
                          color: isLiked
                              ? ColorConstants.accent50
                              : ColorConstants.mono75,
                          size: 30,
                        ),
                      );
                    },
                    onTap: (isLiked) {
                      updateLikes(isLiked);
                      return Future<bool>.value(!isLiked);
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width + 66,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                calories.toString(),
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
                                carbs.toString(),
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
                                protein.toString(),
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
                                fats.toString(),
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
                Positioned(
                  top: MediaQuery.of(context).size.width + 120,
                  child: GradientWidget(
                    gradient: GradientConstants.gradient1,
                    child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width - 2 * 24,
                      color: ColorConstants.mono00,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width + 126,
                  child: Text(
                    ingredients,
                    style: GoogleFonts.montserrat(
                      fontSize: 21,
                      color: ColorConstants.monoAA,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width + 156,
                  child: GradientWidget(
                    gradient: GradientConstants.gradient1,
                    child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width - 2 * 24,
                      color: ColorConstants.mono00,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width + 162,
                  child: Text(
                    ingredients,
                    style: GoogleFonts.montserrat(
                      fontSize: 21,
                      color: ColorConstants.monoAA,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> updateLikes(bool originalState) async {
    if (originalState) {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'saved': FieldValue.arrayRemove([widget.postID])
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'numOfLikes': FieldValue.increment(-1)});
      FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postID)
          .update({'likes': FieldValue.increment(-1)});
    } else {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'saved': FieldValue.arrayUnion([widget.postID])
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'numOfLikes': FieldValue.increment(1)});
      FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postID)
          .update({'likes': FieldValue.increment(1)});
    }
  }
}
