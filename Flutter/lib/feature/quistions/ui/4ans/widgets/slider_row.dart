// feature/quistions/ui/4ans/widgets/slider_row.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SliderRow4ans extends StatelessWidget {
  const SliderRow4ans({
    super.key,
    required this.progress,
    required this.currentStep,
    required this.totalSteps,
  });

  final double progress;
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 1.7.h,
              color: const Color(0xFFD0D0D0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F6A9B),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          '$currentStep of $totalSteps',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF23252B),
          ),
        ),
      ],
    );
  }
}
