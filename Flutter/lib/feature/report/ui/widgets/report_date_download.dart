// feature/report/ui/widgets/report_date_download.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class DateDownloadPdf extends StatelessWidget {
  const DateDownloadPdf({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        horezontalSpace(1),
        Text('Apr 17 - Apr 23', style: TextStyle(fontSize: 20.sp, color: Colors.black87)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 0.5.w),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18.sp),
          ),
          child: Text('Download PDF', style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
        ),
      ],
    );
  }
}
