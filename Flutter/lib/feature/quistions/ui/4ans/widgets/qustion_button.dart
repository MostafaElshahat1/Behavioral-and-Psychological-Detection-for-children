// feature/quistions/ui/4ans/widgets/qustion_button.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QustionButton4ans extends StatelessWidget {
  const QustionButton4ans({
    super.key,
    required this.onNextTap,
    required this.isLastStep,
  });

  final VoidCallback? onNextTap;
  final bool isLastStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onNextTap,
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
            isLastStep ? 'SUBMIT' : 'NEXT',
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
