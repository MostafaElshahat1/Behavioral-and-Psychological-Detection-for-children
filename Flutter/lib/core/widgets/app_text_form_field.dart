// core/widgets/app_text_form_field.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/theming/colors_manager.dart';
import 'package:grade_project/core/theming/text_style.dart';
import 'package:sizer/sizer.dart';

class MyTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentpading;
  final InputBorder? focuseBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String? hinttext;
  final bool? isObsecure;
  final Widget? suffixIcon;
  final Color? formBackgrounfColor;
  final TextEditingController? controller;
  final Function(String?)? validator;
  const MyTextFormField({
    super.key,
    this.contentpading,
    this.focuseBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hinttext,
    this.isObsecure,
    this.suffixIcon,
    this.formBackgrounfColor,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: formBackgrounfColor ?? MyColorsManager.morelightGrey,
        filled: true,
        isDense: true,
        contentPadding:
            contentpading ??
            EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.5.h),
        focusedBorder:
            focuseBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0.w,
                color: MyColorsManager.mainblue,
              ),
              borderRadius: BorderRadius.circular(16.0.sp),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.3,
                color: MyColorsManager.lighterGrey,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: Colors.red),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.3, color: Colors.red),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintStyle: hintStyle ?? MyTextStyles.font15grayreguler,
        hintText: hinttext,
        suffixIcon: suffixIcon,
      ),
      obscureText: isObsecure ?? false,
      style: MyTextStyles.font14DarkBlueMedium,
      validator: (value) {
        return validator!(value);
      },
      controller: controller,
    );
  }
}
