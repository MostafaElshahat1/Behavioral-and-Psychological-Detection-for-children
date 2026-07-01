// feature/report/ui/widgets/report_overview_header.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class EmilysColumn extends StatelessWidget {
  const EmilysColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Emilys Overview', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
        verticalSpace(1),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 199, 115),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Text(
            'MEDIUM RISK',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 251, 247, 238),
            ),
          ),
        ),
      ],
    );
  }
}
