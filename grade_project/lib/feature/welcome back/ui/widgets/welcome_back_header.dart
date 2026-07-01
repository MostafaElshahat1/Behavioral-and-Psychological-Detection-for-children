// feature/welcome back/ui/widgets/welcome_back_header.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackHeader extends StatelessWidget {
  const WelcomeBackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back, size: 22.sp, color: Colors.black87),
            Icon(
              Icons.notifications_none,
              size: 22.sp,
              color: Colors.blue.shade400,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          'Welcome back!',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Ready to check in?',
          style: TextStyle(fontSize: 18.sp, color: Colors.black54),
        ),
      ],
    );
  }
}
