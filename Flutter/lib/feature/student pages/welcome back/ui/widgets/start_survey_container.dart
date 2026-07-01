// feature/parent pages/welcome back/ui/widgets/start_survey_container.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StartServayContainer extends StatelessWidget {
  const StartServayContainer({super.key, required this.onStartSurveyTap});

  final VoidCallback? onStartSurveyTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7.h, bottom: 4.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 14.sp,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: onStartSurveyTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              gradient: const LinearGradient(
                colors: [Color(0xFF5E9ED0), Color(0xFF2A6797)],
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
              'Start the survey',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
