// feature/quistions/ui/4ans/widgets/answer_button.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AnswerButton4ans extends StatelessWidget {
  const AnswerButton4ans({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
        margin: EdgeInsets.symmetric(vertical: 0.8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE7F0F8) : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(22.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: isSelected ? const Color(0xFF5E9ED0) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF2F6A9B),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
