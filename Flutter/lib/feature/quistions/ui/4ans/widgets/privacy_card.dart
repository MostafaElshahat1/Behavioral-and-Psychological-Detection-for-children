// feature/quistions/ui/4ans/widgets/privacy_card.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrivacyCard4ans extends StatelessWidget {
  const PrivacyCard4ans({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.sp),
          topRight: Radius.circular(20.sp),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: const Color(0xFF2F6A9B), size: 24.sp),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              'Your data is private and securely protected',
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF23252B),
              ),
            ),
          ),
          Icon(Icons.shield, color: const Color(0xFFB0B0B0), size: 24.sp),
        ],
      ),
    );
  }
}
