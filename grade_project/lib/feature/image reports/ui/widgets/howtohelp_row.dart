// feature/image reports/ui/widgets/howtohelp_row.dart

import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:sizer/sizer.dart';

class HowToHelpRow extends StatelessWidget {
  const HowToHelpRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        InkWell(
          onTap: () {
            context.pushNamed(IRouts.thankYouScreen);
          },
          child: Container(
            width: 31.w,
            height: 3.7.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF2A6695),
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: Text(
              'How to help',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
