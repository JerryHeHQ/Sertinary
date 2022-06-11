import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/screens/social_screens/post_template.dart';
import 'package:sertinary/screens/social_screens/widgets/post_text_form_field.dart';

class SocialAddPost extends StatefulWidget {
  const SocialAddPost({Key? key}) : super(key: key);

  @override
  State<SocialAddPost> createState() => _SocialAddState();
}

class _SocialAddState extends State<SocialAddPost> {
  User? user = FirebaseAuth.instance.currentUser;

  final _titleFormKey = GlobalKey<FormState>();
  final _caloriesFormKey = GlobalKey<FormState>();
  final _carbsFormKey = GlobalKey<FormState>();
  final _proteinFormKey = GlobalKey<FormState>();
  final _fatsFormKey = GlobalKey<FormState>();
  final _ingredientsFormKey = GlobalKey<FormState>();
  final _instructionsFormKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  bool imageAdded = false;
  late ImageProvider<Object> postPicture;
  File? selectedPostPicture;

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
        child: ListView(
          children: [
            Container(
              color: ColorConstants.mono10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PostTextFormField(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    formKey: _titleFormKey,
                    controller: _titleController,
                    labelText: 'Title',
                    suffixIconActive: true,
                    center: false,
                    multiline: false,
                    onlyNumbers: false,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => selectPostPicture(),
                    child: Container(
                      height: MediaQuery.of(context).size.width - 2 * 24,
                      width: MediaQuery.of(context).size.width - 2 * 24,
                      decoration: BoxDecoration(
                        image: imageAdded
                            ? DecorationImage(
                                image: postPicture,
                                fit: BoxFit.fitWidth,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: imageAdded
                          ? null
                          : Center(
                              child: Transform.scale(
                                scale: 6,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: ColorConstants.mono30,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        PostTextFormField(
                          width: 81,
                          formKey: _caloriesFormKey,
                          controller: _caloriesController,
                          labelText: 'Calories',
                          suffixIconActive: false,
                          center: true,
                          sidePadding: 6.6,
                          labelSize: 12,
                          multiline: false,
                          onlyNumbers: true,
                        ),
                        PostTextFormField(
                          width: 81,
                          formKey: _carbsFormKey,
                          controller: _carbsController,
                          labelText: 'Carbs (g)',
                          suffixIconActive: false,
                          center: true,
                          sidePadding: 6.6,
                          labelSize: 12,
                          multiline: false,
                          onlyNumbers: true,
                        ),
                        PostTextFormField(
                          width: 81,
                          formKey: _proteinFormKey,
                          controller: _proteinController,
                          labelText: 'Protein (g)',
                          suffixIconActive: false,
                          center: true,
                          sidePadding: 6.6,
                          labelSize: 12,
                          multiline: false,
                          onlyNumbers: true,
                        ),
                        PostTextFormField(
                          width: 81,
                          formKey: _fatsFormKey,
                          controller: _fatsController,
                          labelText: 'Fats (g)',
                          suffixIconActive: false,
                          center: true,
                          sidePadding: 6.6,
                          labelSize: 12,
                          multiline: false,
                          onlyNumbers: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  PostTextFormField(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    formKey: _ingredientsFormKey,
                    controller: _ingredientsController,
                    labelText: 'Ingredients',
                    suffixIconActive: true,
                    center: false,
                    maxLines: 12,
                    multiline: true,
                    onlyNumbers: false,
                  ),
                  const SizedBox(height: 12),
                  PostTextFormField(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    formKey: _instructionsFormKey,
                    controller: _instructionsController,
                    labelText: 'Instructions',
                    suffixIconActive: true,
                    center: false,
                    maxLines: 12,
                    multiline: true,
                    onlyNumbers: false,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.center,
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
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
                        child: MaterialButton(
                          height: 30,
                          onPressed: () {
                            uploadPost();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(width: 15),
                              Text(
                                'Upload Post ',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.mono05,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.upload_file_outlined,
                                color: ColorConstants.mono05,
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectPostPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      imageAdded = true;
      selectedPostPicture = File(imageFile.path);
      postPicture = FileImage(selectedPostPicture!);
      setState(() {});
    }
  }

  uploadPost() async {
    if (_titleController.text.isEmpty ||
        _caloriesController.text.isEmpty ||
        _carbsController.text.isEmpty ||
        _proteinController.text.isEmpty ||
        _fatsController.text.isEmpty ||
        _ingredientsController.text.isEmpty ||
        _instructionsController.text.isEmpty) {
      showMessage(true, ' Not All Fields Are Filled');
      return;
    }

    if (selectedPostPicture == null) {
      showMessage(true, ' Please Select An Image');
      return;
    }

    bool errorOccurred = false;

    try {
      PostTemplate post = PostTemplate(
        uid: user!.uid,
        title: _titleController.text,
        calories: int.parse(_caloriesController.text),
        carbs: int.parse(_carbsController.text),
        protein: int.parse(_proteinController.text),
        fats: int.parse(_fatsController.text),
        ingredients: _ingredientsController.text,
        instructions: _instructionsController.text,
      );

      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('posts')
          .add(post.toMap());

      String postID = docRef.id;

      await FirebaseStorage.instance
          .ref()
          .child('PostPictures')
          .child(postID)
          .putFile(selectedPostPicture!);

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'posts': FieldValue.arrayUnion([postID])
      }, SetOptions(merge: true));
    } on FirebaseException {
      errorOccurred = true;
    }

    if (errorOccurred) {
      showMessage(errorOccurred, ' An Error Occured When Uploading Your Post');
    } else {
      showMessage(errorOccurred, ' Your Post Has Been Successfully Uploaded');
    }
  }

  showMessage(errorOccurred, String text) {
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
              text,
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
