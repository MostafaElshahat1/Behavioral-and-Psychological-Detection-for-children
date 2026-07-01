// feature/image reports/ui/widgets/check_date_row.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckDateRow extends StatelessWidget {
  const CheckDateRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Text(
                'dd/mm/yyyy',
                style: TextStyle(
                  color: const Color(0xFF8A8A8A),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            width: 24.w,
            height: 3.8.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF2A6695),
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: Text(
              'check',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
