import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sertinary/common_functions.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/form_field_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/screens/social_screens/widgets/circular_picture.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class SocialEditProfile extends StatefulWidget {
  const SocialEditProfile({Key? key}) : super(key: key);

  @override
  State<SocialEditProfile> createState() => _SocialEditProfileState();
}

class _SocialEditProfileState extends State<SocialEditProfile> {
  bool dataAcquired = false;

  User? user = FirebaseAuth.instance.currentUser;

  late ImageProvider<Object> coverPicture;
  late ImageProvider<Object> profilePicture;

  File? selectedCoverPicture;
  File? selectedProfilePicture;

  late Map<String, dynamic> userData;
  late String username;
  late String bio;
  late int numOfPosts;
  late int numOfFollowers;
  late int numOfLikes;

  final _usernameFormKey = GlobalKey<FormState>();
  final _bioFormKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _bioController;

  Color _usernameLabelColor = ColorConstants.mono75;
  Color _bioLabelColor = ColorConstants.mono75;

  bool hasBeenInitialized = false;

  late Reference coverRef;
  late Reference profileRef;

  getCoverPicture() async {
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

    _usernameController = TextEditingController(text: username);
    _bioController = TextEditingController(text: bio);
  }

  Future<dynamic> getData() async {
    if (!hasBeenInitialized) {
      await getCoverPicture();
      await getProfilePicture();
      await getUserData();
      hasBeenInitialized = true;
    }
    dataAcquired = true;
  }

  @override
  void initState() {
    coverRef =
        FirebaseStorage.instance.ref().child('CoverPictures').child(user!.uid);
    profileRef = FirebaseStorage.instance
        .ref()
        .child('ProfilePictures')
        .child(user!.uid);
    super.initState();
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
                GestureDetector(
                  onTap: () {
                    selectCoverPicture();
                  },
                  child: Container(
                    height: 240,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: coverPicture,
                        fit: BoxFit.cover,
                      ),
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
                        onPressed: () {
                          selectProfilePicture();
                        },
                      ),
                      const SizedBox(height: 18),
                      //Username Form Field
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 2 * 24,
                        child: Form(
                          key: _usernameFormKey,
                          onChanged: () => setState(
                            () => _usernameFormKey.currentState!.validate(),
                          ),
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              setState(() => _usernameLabelColor = hasFocus
                                  ? ColorConstants.accent50
                                  : ColorConstants.mono75);
                            },
                            child: TextFormField(
                              autofocus: false,
                              controller: _usernameController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('Please Enter Your Preferred Username');
                                }
                                if (!RegExp(r'^[A-Za-z]').hasMatch(value)) {
                                  return ('The First Character Must Be A Letter');
                                }
                                if (!RegExp(r'^.{3,}$').hasMatch(value)) {
                                  return ('Your Username Must Be At Least 3 Characters Long');
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _usernameController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              cursorColor: ColorConstants.accent50,
                              cursorHeight: 18,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.mono95,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                fillColor: ColorConstants.mono10,
                                filled: true,
                                prefixIcon: GradientWidget(
                                  gradient: GradientConstants.gradient1,
                                  child: Icon(
                                    Icons.person_outline,
                                    color: ColorConstants.accent50,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: GradientWidget(
                                    gradient: GradientConstants.gradient1,
                                    child: Icon(
                                      Icons.clear_rounded,
                                      color: ColorConstants.accent50,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _usernameController.clear();
                                      },
                                    );
                                  },
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(18, 21, 18, 21),
                                labelText: 'Username',
                                labelStyle: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: _usernameLabelColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                enabledBorder: FormFieldConstants.enabledBorder,
                                focusedBorder: FormFieldConstants.focusedBorder,
                                errorBorder: FormFieldConstants.errorBorder,
                                focusedErrorBorder:
                                    FormFieldConstants.focusedErrorBorder,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      //Biography Form Field
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 2 * 24,
                        child: Form(
                          key: _bioFormKey,
                          onChanged: () => setState(
                            () => _bioFormKey.currentState!.validate(),
                          ),
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              setState(() => _bioLabelColor = hasFocus
                                  ? ColorConstants.accent50
                                  : ColorConstants.mono75);
                            },
                            child: TextFormField(
                              autofocus: false,
                              controller: _bioController,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                return null;
                              },
                              onSaved: (value) {
                                _bioController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              cursorColor: ColorConstants.accent50,
                              cursorHeight: 18,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.mono95,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                fillColor: ColorConstants.mono10,
                                filled: true,
                                prefixIcon: GradientWidget(
                                  gradient: GradientConstants.gradient1,
                                  child: Icon(
                                    Icons.text_snippet_outlined,
                                    color: ColorConstants.accent50,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: GradientWidget(
                                    gradient: GradientConstants.gradient1,
                                    child: Icon(
                                      Icons.clear_rounded,
                                      color: ColorConstants.accent50,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _bioController.clear();
                                      },
                                    );
                                  },
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(18, 21, 18, 21),
                                labelText: 'Biography',
                                labelStyle: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: _bioLabelColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                enabledBorder: FormFieldConstants.enabledBorder,
                                focusedBorder: FormFieldConstants.focusedBorder,
                                errorBorder: FormFieldConstants.errorBorder,
                                focusedErrorBorder:
                                    FormFieldConstants.focusedErrorBorder,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
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
                      //Save Edits Button
                      GestureDetector(
                        onTap: () {
                          if (_usernameFormKey.currentState!.validate()) {
                            updateUserProfile();
                          }
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
                              Icons.cloud_upload_outlined,
                              color: ColorConstants.mono05,
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

  selectCoverPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      selectedCoverPicture = File(imageFile.path);
      coverPicture = FileImage(selectedCoverPicture!);
      setState(() {});
    }
  }

  selectProfilePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      selectedProfilePicture = File(imageFile.path);
      profilePicture = FileImage(selectedProfilePicture!);
      setState(() {});
    }
  }

  updateUserProfile() async {
    bool errorOccurred = false;

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    await userDoc.update({'username': _usernameController.text}).onError(
        (error, stackTrace) {
      errorOccurred = true;
    });
    await userDoc
        .update({'bio': _bioController.text}).onError((error, stackTrace) {
      errorOccurred = true;
    });

    if (selectedCoverPicture != null) {
      try {
        await coverRef.delete();
      } on FirebaseException {
        errorOccurred = true;
      }

      await FirebaseStorage.instance
          .ref()
          .child('CoverPictures')
          .child(user!.uid)
          .putFile(selectedCoverPicture!);
    }

    if (selectedProfilePicture != null) {
      try {
        await profileRef.delete();
      } on FirebaseException {
        errorOccurred = true;
      }

      await FirebaseStorage.instance
          .ref()
          .child('ProfilePictures')
          .child(user!.uid)
          .putFile(selectedProfilePicture!);
    }

    showMessage(errorOccurred);
  }

  showMessage(errorOccurred) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConstants.mono10,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              errorOccurred
                  ? Icons.error_outline_rounded
                  : Icons.check_box_outlined,
              color:
                  errorOccurred ? ColorConstants.fail : ColorConstants.success,
            ),
            Text(
              errorOccurred
                  ? ' An Error Occured When Updating Your Profile'
                  : ' Your Profile Has Been Successfully Updated',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 13,
                  color: errorOccurred
                      ? ColorConstants.fail
                      : ColorConstants.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
