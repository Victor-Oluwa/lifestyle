// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/typeDef/type_def.dart';
import '../colors/lifestyle_colors.dart';
import '../fonts/lifestyle_fonts.dart';

class FloatingTextEditor extends StatefulWidget {
  const FloatingTextEditor({
    Key? key,
    required this.focusNode,
    this.obscureText = false,
    required this.controller,
    this.suffixIcon,
    this.icon,
    this.validate,
    required this.label,
    this.fillColor = LifestyleColors.kTaupeBackground,
    this.materialColor = LifestyleColors.kTaupeBackground,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.maxLine,
    this.onChanged,
  }) : super(key: key);
  final FocusNode focusNode;
  final bool obscureText;
  final TEC controller;
  final Widget? suffixIcon;
  final Widget? icon;
  final String? Function(String?)? validate;
  final Widget label;
  final Color? fillColor;
  final Color? materialColor;
  final bool readOnly;
  final int? maxLine;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  State<FloatingTextEditor> createState() => _FloatingTextEditorState();
}

class _FloatingTextEditorState extends State<FloatingTextEditor> {
  @override
  Widget build(BuildContext context) {
    return Material(
      animationDuration: const Duration(seconds: 1),
      color: LifestyleColors.kTaupeBackground,
      shadowColor: LifestyleColors.black,
      borderRadius: BorderRadius.circular(8.sp),
      elevation: widget.focusNode.hasFocus ? 10.sp : 7.sp,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: null,
        padding: EdgeInsets.only(top: 16.sp, bottom: 0.sp, left: 2.w),
        child: TextFormField(
          onChanged: widget.onChanged,
          maxLines: widget.maxLine,
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          validator: widget.validate,
          obscureText: widget.obscureText,
          controller: widget.controller,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: const TextStyle(fontFamily: LifestyleFonts.kComorantMedium),
          decoration: InputDecoration(
              fillColor: widget.fillColor,
              filled: true,
              icon: widget.icon,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(7.sp))),
              label: widget.label,
              suffixIcon: widget.suffixIcon),
        ),
      ),
    );
  }
}
