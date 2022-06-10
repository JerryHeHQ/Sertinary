import 'package:flutter/material.dart';
import 'package:sertinary/constants/gradient_constants.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.width,
    required this.height,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  final double width;
  final double height;
  final Icon icon;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: GradientConstants.gradient1,
      ),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}
