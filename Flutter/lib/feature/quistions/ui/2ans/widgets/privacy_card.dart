// feature/quistions/ui/widgets/privacy_card.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrivacyCard extends StatelessWidget {
  const PrivacyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 1.8.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.3.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(16.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.verified_user,
                  color: const Color(0xFF2F6A9B),
                  size: 21.sp,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Your data is private\nand securely protected',
                    style: TextStyle(
                      fontSize: 11.8.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF23252B),
                      height: 1.3,
                    ),
                  ),
                ),
                Icon(Icons.shield, color: const Color(0xFF8A8D90), size: 26.sp),
              ],
            ),
            SizedBox(height: 1.05.h),
            Divider(height: 1, color: Colors.black.withOpacity(0.2)),
          ],
        ),
      ),
    );
  }
}
