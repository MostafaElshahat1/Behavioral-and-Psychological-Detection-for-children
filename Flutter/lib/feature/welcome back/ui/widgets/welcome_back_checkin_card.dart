// feature/welcome back/ui/widgets/welcome_back_checkin_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/welcome%20back/ui/widgets/welcome_back_rounded_card.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackCheckinCard extends StatelessWidget {
  const WelcomeBackCheckinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeBackRoundedCard(
      child: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E6EB3),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.2.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.sp),
            ),
            elevation: 8,
            shadowColor: Colors.black12,
          ),
          onPressed: () {
            context.pushNamed(IRouts.welcomeBack2Page);
          },
          icon: Icon(Icons.check_circle, size: 20.sp, color: Colors.white),
          label: Text(
            "Take today's check-in",
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
