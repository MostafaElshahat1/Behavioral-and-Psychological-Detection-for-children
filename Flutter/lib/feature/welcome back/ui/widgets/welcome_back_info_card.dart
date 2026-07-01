// feature/welcome back/ui/widgets/welcome_back_info_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/welcome%20back/ui/widgets/welcome_back_rounded_card.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackInfoCard extends StatelessWidget {
  const WelcomeBackInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeBackRoundedCard(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.security, color: Colors.blue.shade200, size: 20.sp),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Your data is private and securely protected.',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.blue.shade200,
                size: 18.sp,
              ),
            ],
          ),
          SizedBox(height: 1.2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pageDot(Colors.grey.shade300),
              SizedBox(width: 2.w),
              _pageDot(Colors.grey.shade300),
              SizedBox(width: 2.w),
              _pageDot(Colors.grey.shade300.withOpacity(0.4)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageDot(Color color) {
    return Container(
      width: 2.w,
      height: 0.9.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.sp),
      ),
    );
  }
}
