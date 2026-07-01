// feature/thank you/widgets/tip_row.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TipRow extends StatelessWidget {
  const TipRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.2.w, vertical: 1.3.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: const Color.fromARGB(235, 75, 135, 187),
            size: 18.sp,
          ),
          SizedBox(width: 5.w),
          Text(
            text,
            style: TextStyle(
              color: const Color(0xFF1B1B1B),
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
