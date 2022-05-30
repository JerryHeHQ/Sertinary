import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBox extends StatefulWidget {
  final double width;
  final double height;
  final double blur;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final List<Color> gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const GlassBox({
    Key? key,
    required this.width,
    required this.height,
    required this.blur,
    required this.borderRadius,
    required this.borderColor,
    required this.borderWidth,
    required this.gradientColors,
    required this.gradientBegin,
    required this.gradientEnd,
    required this.padding,
    required this.child,
  }) : super(key: key);

  @override
  State<GlassBox> createState() => _GlassBoxState();
}

class _GlassBoxState extends State<GlassBox> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.blur,
                sigmaY: widget.blur,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                gradient: LinearGradient(
                  begin: widget.gradientBegin,
                  end: widget.gradientEnd,
                  colors: widget.gradientColors,
                ),
              ),
            ),
            Container(
              padding: widget.padding,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
