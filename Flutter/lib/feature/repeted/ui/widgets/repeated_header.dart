// feature/repeted/ui/widgets/repeated_header.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class RepeatedHeader extends StatelessWidget {
  const RepeatedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Repeated aggression detected',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              verticalSpace(1),
              Text(
                'Friday',
                style: TextStyle(fontSize: 18.sp, color: Colors.black45),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
