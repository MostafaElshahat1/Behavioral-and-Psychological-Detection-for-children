// feature/thank you/widgets/thank_you_top_header.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:sizer/sizer.dart';

class ThankYouTopHeader extends StatelessWidget {
  const ThankYouTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 7.h,
          left: -6.h,
          right: -6.h,
          bottom: 0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 232, 252),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60.h),
                bottomRight: Radius.circular(60.h),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.w, top: 3.h),
          child: Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => context.pushNamedAndRemoveUntil(
                IRouts.welcomeBackStudentScreen,
                predicate: (_) => false,
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: const Color(0xFF4A4A4A),
                size: 30.sp,
              ),
            ),
          ),
        ),
        Positioned(
          top: 7.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              SizedBox(height: 0.7.h),
              Text(
                'Thank you!',
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF183048),
                ),
              ),
              SizedBox(height: 1.4.h),
              Image.asset(
                'assets/onpord_home_new.png',
                height: 27.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
