// feature/quistions/ui/2ans/widgets/slider_row.dart

import 'package:flutter/material.dart';
import 'package:grade_project/feature/quistions/ui/2ans/questions2ans_screen.dart';
import 'package:sizer/sizer.dart';

class SliderRow extends StatelessWidget {
  const SliderRow({super.key, required double progress, required this.widget})
    : _progress = progress;

  final double _progress;
  final QuestionsScreen2ans widget;

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
                  widthFactor: _progress,
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
          '${widget.currentStep} of ${widget.totalSteps}',
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
