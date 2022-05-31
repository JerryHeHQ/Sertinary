import 'package:flutter/material.dart';

class SocialViewPost extends StatefulWidget {
  const SocialViewPost({Key? key, required this.postID}) : super(key: key);

  final int postID;

  @override
  State<SocialViewPost> createState() => _SocialPostState();
}

class _SocialPostState extends State<SocialViewPost> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
