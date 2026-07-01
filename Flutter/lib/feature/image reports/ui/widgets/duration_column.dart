// feature/image reports/ui/widgets/duration_column.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DurationColumn extends StatelessWidget {
  const DurationColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    
      children: [
        Text(
          'duration',
          style: TextStyle(
            color: const Color(0xFF191919),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 0.8.h),
        Text(
          'time stamp',
          style: TextStyle(
            color: const Color(0xFF7A7A7A),
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
