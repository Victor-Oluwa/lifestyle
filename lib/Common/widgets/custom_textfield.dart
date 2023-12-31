// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/widgets/app_constants.dart';

import 'medium_text.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    required this.hintText,
    this.readOnly = false,
    this.selection,
    this.textInputType,
    this.signInFormKey,
    this.validator = fieldValidator,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final String hintText;
  final bool readOnly;
  final bool? selection;
  final TextInputType? textInputType;
  final Key? signInFormKey;
  final String? Function(String?)? validator;
  // final Color? borderColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.signInFormKey,
      keyboardType: widget.textInputType,
      style: TextStyle(fontFamily: comorant),
      readOnly: widget.readOnly,
      enableInteractiveSelection: widget.selection,
      cursorColor: Colors.white,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(5.sp),
          ),
        ),
        focusColor: Colors.white,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        label: MediumText(
          font: comorant,
          text: widget.label,
          color: Colors.white,
        ),
        hintText: widget.hintText,
        hintTextDirection: TextDirection.ltr,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(5.sp),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(5.sp),
          ),
        ),
      ),
      validator: widget.validator,
      maxLines: widget.maxLines,
    );
  }
}

String? fieldValidator(String? val) {
  if (val == null || val.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}
