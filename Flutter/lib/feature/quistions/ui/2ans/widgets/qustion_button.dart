// feature/quistions/ui/2ans/widgets/qustion_button.dart

import 'package:flutter/material.dart';
import 'package:grade_project/feature/quistions/ui/2ans/questions2ans_screen.dart';
import 'package:sizer/sizer.dart';

class QustionButton extends StatelessWidget {
  const QustionButton({super.key, required this.widget});

  final QuestionsScreen2ans widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onNextTap,
        child: Container(
          width: 35.w,
          padding: EdgeInsets.symmetric(vertical: 1.2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.sp),
            gradient: const LinearGradient(
              colors: [Color(0xFF9EC1DE), Color(0xFF6D9EC4)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            widget.isLastStep ? 'SUBMIT' : 'NEXT',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
