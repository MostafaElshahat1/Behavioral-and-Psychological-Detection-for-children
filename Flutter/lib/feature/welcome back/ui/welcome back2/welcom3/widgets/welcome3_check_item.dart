// feature/welcome back/ui/welcome back2/welcom3/widgets/welcome3_check_item.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Welcome3CheckItem extends StatelessWidget {
  const Welcome3CheckItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 3.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Row(
        children: [
          Container(
            width: 6.5.w,
            height: 6.5.w,
            decoration: const BoxDecoration(
              color: Color(0xFF2E6EB3),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 18.sp),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18.sp, color: const Color(0xFF11223A)),
            ),
          ),
        ],
      ),
    );
  }
}
