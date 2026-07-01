// feature/thank you/widgets/thank_you_content.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/thank%20you/widgets/tip_row.dart';
import 'package:sizer/sizer.dart';

class ThankYouContent extends StatelessWidget {
  const ThankYouContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'your check-in has been\nsubmitted',
          style: TextStyle(
            color: const Color(0xFF111111),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        verticalSpace(0.2.h),
        Text(
          "we'll let the counselor know if you\nneed support",
          style: TextStyle(
            color: const Color(0xFF7F7F7F),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
        ),
        verticalSpace(0.2.h),
        Text(
          'Your answers are private and secure',
          style: TextStyle(
            color: const Color(0xFF141414),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpace(0.2.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDBE3EA),
            borderRadius: BorderRadius.circular(4.w),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Column(
            children: [
              TipRow(text: 'Take a deep breathe'),
              Divider(height: 1, color: Color(0xFFB4BEC9)),
              TipRow(text: 'Take a deep breathe'),
              Divider(height: 1, color: Color(0xFFB4BEC9)),
              TipRow(text: 'Take a deep breathe'),
            ],
          ),
        ),
      ],
    );
  }
}
