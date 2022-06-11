import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/form_field_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/widgets/gradient_widget.dart';

class PostTextFormField extends StatefulWidget {
  double width;
  GlobalKey<FormState> formKey;
  TextEditingController controller;
  String labelText;
  double? labelSize;
  Widget? prefixIcon;
  bool suffixIconActive;
  bool center;
  double? sidePadding;
  int? maxLines;
  int? minLines;
  bool multiline;
  bool onlyNumbers;

  PostTextFormField({
    Key? key,
    required this.width,
    required this.formKey,
    required this.controller,
    required this.labelText,
    this.labelSize,
    this.prefixIcon,
    required this.suffixIconActive,
    required this.center,
    this.sidePadding,
    this.maxLines,
    this.minLines,
    required this.multiline,
    required this.onlyNumbers,
  }) : super(key: key);

  @override
  State<PostTextFormField> createState() => _PostTextFormFieldState();
}

class _PostTextFormFieldState extends State<PostTextFormField> {
  Color labelColor = ColorConstants.mono75;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Form(
        key: widget.formKey,
        onChanged: () => setState(
          () => widget.formKey.currentState!.validate(),
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            log(widget.labelText + hasFocus.toString());
            setState(() => labelColor =
                hasFocus ? ColorConstants.accent50 : ColorConstants.mono75);
          },
          child: TextFormField(
            autofocus: false,
            controller: widget.controller,
            keyboardType:
                widget.multiline ? TextInputType.multiline : TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return ('');
              }
              return null;
            },
            onSaved: (value) {
              widget.controller.text = value!;
            },
            inputFormatters: widget.onlyNumbers
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]
                : null,
            textInputAction: TextInputAction.next,
            cursorColor: ColorConstants.accent50,
            cursorHeight: 18,
            textAlign: widget.center ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.mono95,
              fontWeight: FontWeight.w600,
            ),
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLines ?? 1,
            decoration: InputDecoration(
              fillColor: ColorConstants.mono10,
              filled: true,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIconActive
                  ? IconButton(
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
                            widget.controller.clear();
                          },
                        );
                      },
                    )
                  : null,
              contentPadding: EdgeInsets.fromLTRB(
                  widget.sidePadding ?? 18, 21, widget.sidePadding ?? 18, 21),
              errorStyle: const TextStyle(fontSize: 0.01),
              labelText: widget.labelText,
              labelStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: widget.labelSize ?? 16,
                  color: labelColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              floatingLabelAlignment:
                  widget.center ? FloatingLabelAlignment.center : null,
              enabledBorder: FormFieldConstants.enabledBorder,
              focusedBorder: FormFieldConstants.focusedBorder,
              errorBorder: FormFieldConstants.errorBorder,
              focusedErrorBorder: FormFieldConstants.focusedErrorBorder,
            ),
          ),
        ),
      ),
    );
  }
}
