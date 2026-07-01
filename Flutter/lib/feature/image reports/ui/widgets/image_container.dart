// feature/image reports/ui/widgets/image_container.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.h),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4.3.w),
      ),
      // borderRadius: BorderRadius.circular(4.w),
      child: ClipRRect(
        child: Image.asset(
          'assets/onpord_page.png',
          height: 14.h,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) {
            return Container(
              height: 14.h,
              color: const Color(0xFFCFCFCF),
              alignment: Alignment.center,
              child: Text(
                'img',
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
