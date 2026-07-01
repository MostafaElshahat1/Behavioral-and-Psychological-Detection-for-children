// feature/welcome back/ui/welcome back2/welcom3/widgets/welcome3_content.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/welcome%20back/ui/welcome%20back2/welcom3/widgets/welcome3_check_item.dart';
import 'package:sizer/sizer.dart';

class Welcome3Content extends StatelessWidget {
  const Welcome3Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 1.h),
          Text(
            'Thank you!',
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF11223A),
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            width: 40.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Center(
              child: Icon(Icons.school, size: 36.sp, color: const Color(0xFF2E6EB3)),
            ),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your check-in has been submitted',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF11223A),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'We\'ll let the counselor know if you need support.\nYour answers are private and secure.',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17.sp, color: Colors.black54),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.sp),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: const Column(
              children: [
                Welcome3CheckItem(text: 'Take a deep breath'),
                SizedBox(height: 12),
                Welcome3CheckItem(text: 'Stretch for a minute'),
                SizedBox(height: 12),
                Welcome3CheckItem(text: 'Focus on something calming'),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Dot(color: Color(0xFFD7D7D7)),
              SizedBox(width: 2.w),
              _Dot(color: Color(0x66D7D7D7)),
              SizedBox(width: 2.w),
              _Dot(color: Color(0x66D7D7D7)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.w,
      height: 0.6.h,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6.sp)),
    );
  }
}
