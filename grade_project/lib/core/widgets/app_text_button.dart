// core/widgets/app_text_button.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/theming/colors_manager.dart';
import 'package:sizer/sizer.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    this.buttonhight,
    this.buttonwidth,
    this.buttonText,
    this.textStyle,
    this.onpressed,
    this.borderRadius,
    this.backGroundColor,
    this.horezentalPading,
    this.verticalPading,
  });
  final double? buttonhight;
  final double? borderRadius;
  final double? buttonwidth;
  final double? horezentalPading;
  final double? verticalPading;
  final String? buttonText;
  final TextStyle? textStyle;
  final VoidCallback? onpressed;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          backGroundColor ?? MyColorsManager.mainblue,
        ),
        // padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
        //     horizontal: horezentalPading?.w ?? 12.w,
        //     vertical: verticalPading?.h ?? 14.h)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 52)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.sp),
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonwidth?.w ?? double.maxFinite, buttonhight?.h ?? 5.h),
        ),
      ),
      child: Text(buttonText!, style: textStyle),
    );
  }
}
