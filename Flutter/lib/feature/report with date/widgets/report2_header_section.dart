// feature/report with date/widgets/report2_header_section.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:sizer/sizer.dart';

class Report2HeaderSection extends StatelessWidget {
  const Report2HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Icon(
                Icons.arrow_back_rounded,
                color: const Color(0xFF4A4A4A),
                size: 30.sp,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                context.pushNamed(IRouts.notificationScreen);
              },
              child: Icon(
                Icons.notifications,
                color: const Color(0xFF1F5F91),
                size: 25.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.7.h),
        Text(
          'Reports',
          style: TextStyle(
            fontSize: 23.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF101010),
          ),
        ),
        SizedBox(height: 2.h),

        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(14.sp),
        //     boxShadow: const [
        //       BoxShadow(
        //         color: Color.fromRGBO(0, 0, 0, 0.12),
        //         blurRadius: 18,
        //         offset: Offset(0, 8),
        //       ),
        //     ],
        //   ),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 2.w),
        //           child: Text(
        //             'dd/mm/yyyy',
        //             style: TextStyle(
        //               color: const Color(0xFF8A8A8A),
        //               fontSize: 18.sp,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ),
        //       ),
        //       Container(
        //         width: 24.w,
        //         height: 3.8.h,
        //         alignment: Alignment.center,
        //         decoration: BoxDecoration(
        //           color: const Color(0xFF2A6695),
        //           borderRadius: BorderRadius.circular(7.w),
        //         ),
        //         child: Text(
        //           'check',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 16.sp,
        //             fontWeight: FontWeight.w700,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
