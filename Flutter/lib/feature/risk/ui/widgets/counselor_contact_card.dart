// feature/risk/ui/widgets/counselor_contact_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class CounselorContactCard extends StatelessWidget {
  const CounselorContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.w,
            offset: Offset(0, 1.w),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 6.w,
                      backgroundImage: null,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 6.w, color: Colors.white),
                    ),
                    horezontalSpace(4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. JTAME Smith',
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        Text(
                          'School Counselor',
                          style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(1),
                Row(
                  children: [
                    Icon(Icons.phone, size: 6.w, color: Colors.blueGrey),
                    SizedBox(width: 2.w),
                    Text('+1 (1233) 456-7890', style: TextStyle(fontSize: 16.sp)),
                  ],
                ),
                verticalSpace(0.8),
                Row(
                  children: [
                    Icon(Icons.email_outlined, size: 6.w, color: Colors.blueGrey),
                    SizedBox(width: 2.w),
                    Text('counselor@example.com', style: TextStyle(fontSize: 18.sp)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
