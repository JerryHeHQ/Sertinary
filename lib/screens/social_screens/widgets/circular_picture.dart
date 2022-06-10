import 'package:flutter/material.dart';

class CircularPicture extends StatelessWidget {
  final double height;
  final double width;
  final ImageProvider<Object>? image;
  final void Function() onPressed;

  const CircularPicture({
    Key? key,
    required this.height,
    required this.width,
    this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: image ?? const AssetImage('assets/images/DefaultPFP.png'),
          ),
        ),
      ),
    );
  }
}
