// feature/thank you/thank you_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/thank%20you/widgets/thank_you_content.dart';
import 'package:grade_project/feature/thank%20you/widgets/thank_you_top_header.dart';
import 'package:sizer/sizer.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 2.h),
            height: 46.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 232, 252),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60.h),
                bottomRight: Radius.circular(60.h),
              ),
            ),
            child: const ThankYouTopHeader(),
          ),
          verticalSpace(2.5),
          Expanded(
            child: Container(
              color: const Color.fromARGB(132, 255, 255, 255),

              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 6.4.w,
                  vertical: 2.2.h,
                ),
                child: const ThankYouContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
