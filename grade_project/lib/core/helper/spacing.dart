// core/helper/spacing.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SizedBox verticalSpace(double height) => SizedBox(
      height: height.h,
    );

SizedBox horezontalSpace(double width) => SizedBox(
      width: width.w,
    );
