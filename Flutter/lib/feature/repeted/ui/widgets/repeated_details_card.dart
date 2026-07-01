// feature/repeted/ui/widgets/repeated_details_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class RepeatedDetailsCard extends StatelessWidget {
  const RepeatedDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.w,
            offset: Offset(0, 1.5.w),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What this means',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Emily was involved in repeated aggressive behavior in class over the last few days. Signs of bullying, frequent disturbances, or conflicts were observed.',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            SizedBox(height: 3.h),
            Divider(color: Colors.grey.shade200, thickness: 1),
            SizedBox(height: 2.h),
            Text(
              'What you can do',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2.h),
            const RepeatedActionItem(
              text:
                  'Have a calm conversion with Emily to understand what\'s going on.',
            ),
            SizedBox(height: 2.h),
            const RepeatedActionItem(
              text: 'Talk to her teacher about the incidents.',
            ),
            SizedBox(height: 2.h),
            const RepeatedActionItem(
              text: 'Reach out the school counselor for advice.',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class RepeatedActionItem extends StatelessWidget {
  const RepeatedActionItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Icon(Icons.info, color: const Color(0xFF2B6FA6), size: 24.sp),
        ),
        horezontalSpace(2),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
