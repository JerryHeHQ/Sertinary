import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';

class SearchBar extends StatefulWidget {
  double maxWidth;
  TextEditingController textEditingController;
  void Function() suffixPressed;

  SearchBar({
    Key? key,
    required this.maxWidth,
    required this.textEditingController,
    required this.suffixPressed,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

bool toggle = false;

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    widget.textEditingController = TextEditingController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(-1, 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        height: 48,
        width: toggle ? widget.maxWidth : 48,
        curve: Curves.easeOut,
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
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 420),
              right: 0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: toggle ? 1 : 0,
                duration: const Duration(milliseconds: 420),
                child: AnimatedBuilder(
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: animationController.value * 2 * pi,
                      child: widget,
                    );
                  },
                  animation: animationController,
                  child: IconButton(
                    splashRadius: 18,
                    icon: const Icon(
                      Icons.filter_list_outlined,
                      size: 24,
                    ),
                    onPressed: widget.suffixPressed,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 420),
              left: 36,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: toggle ? 1 : 0,
                duration: const Duration(milliseconds: 420),
                child: SizedBox(
                  height: 39,
                  width: 180,
                  child: TextField(
                    controller: widget.textEditingController,
                    cursorRadius: const Radius.circular(9),
                    cursorWidth: 2.4,
                    cursorHeight: 18,
                    cursorColor: ColorConstants.mono00,
                    style: GoogleFonts.montserrat(
                      color: ColorConstants.mono00,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Search...',
                      labelStyle: GoogleFonts.montserrat(
                        color: ColorConstants.mono00,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              left: 0,
              duration: const Duration(milliseconds: 420),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                child: IconButton(
                  splashRadius: 0.01,
                  icon: const Icon(
                    Icons.search,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        if (toggle) {
                          toggle = !toggle;
                          widget.textEditingController.clear();
                          animationController.reverse();
                        } else {
                          toggle = !toggle;
                          animationController.forward();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
