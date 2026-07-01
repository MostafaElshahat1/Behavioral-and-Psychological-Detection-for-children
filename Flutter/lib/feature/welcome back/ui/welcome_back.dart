// feature/welcome back/ui/welcome_back.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/welcome%20back/ui/widgets/welcome_back_checkin_card.dart';
import 'package:grade_project/feature/welcome%20back/ui/widgets/welcome_back_header.dart';
import 'package:grade_project/feature/welcome%20back/ui/widgets/welcome_back_info_card.dart';
import 'package:grade_project/feature/welcome%20back/ui/widgets/welcome_back_mood_card.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackPage extends StatelessWidget {
  const WelcomeBackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(
      //     context,
      //   ).push(MaterialPageRoute(builder: (_) => const WelcomeBack2Page())),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeBackHeader(),
                SizedBox(height: 4.h),
                const WelcomeBackCheckinCard(),
                SizedBox(height: 4.h),
                const WelcomeBackMoodCard(),
                const WelcomeBackInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
