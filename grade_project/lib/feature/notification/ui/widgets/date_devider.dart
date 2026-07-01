// feature/notification/ui/widgets/date_devider.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DateDivider extends StatelessWidget {
  const DateDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFD5D5D5))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF9B9B9B),
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFD5D5D5))),
      ],
    );
  }
}
