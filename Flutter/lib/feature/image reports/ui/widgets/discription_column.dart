// feature/image reports/ui/widgets/discription_column.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DescriptionColumn extends StatelessWidget {
  const DescriptionColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'description',
          style: TextStyle(
            color: const Color(0xFF191919),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 0.8.h),
        Text(
          'emily was involved in repeated\n'
          'aggressive behavior in class over\n'
          'the last few days .signs of\n'
          'bullying .frequent disturbances ,\n'
          'or conflicts were observed',
          style: TextStyle(
            color: const Color(0xFF7A7A7A),
            fontSize: 17.sp,
            height: 1.35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
