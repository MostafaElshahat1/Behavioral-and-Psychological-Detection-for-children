// feature/welcome back/ui/widgets/welcome_back_mood_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/welcome%20back/ui/widgets/welcome_back_rounded_card.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackMoodCard extends StatelessWidget {
  const WelcomeBackMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeBackRoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hang mood streak',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  _dot(),
                  SizedBox(width: 2.w),
                  _dot(),
                ],
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _moodButton(
                Colors.green.shade100,
                Icons.sentiment_very_satisfied,
                30.sp,
              ),
              _moodButton(
                Colors.lightGreen.shade100,
                Icons.sentiment_satisfied,
                30.sp,
              ),
              _moodButton(
                Colors.yellow.shade100,
                Icons.sentiment_neutral,
                30.sp,
              ),
              _addButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 3.w,
      height: 3.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _moodButton(Color bg, IconData icon, double size) {
    return Container(
      width: 14.w,
      height: 14.w,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Center(
        child: Icon(icon, color: Colors.black54, size: size),
      ),
    );
  }

  Widget _addButton() {
    return Container(
      width: 14.w,
      height: 14.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Icon(Icons.add, size: 24.sp, color: Colors.black54),
      ),
    );
  }
}
