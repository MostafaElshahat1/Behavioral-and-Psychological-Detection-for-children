// feature/risk/ui/widgets/alerts_card.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.w,
            offset: Offset(0, 1.2.w),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alerts',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.black26, size: 22.sp),
            ],
          ),
          SizedBox(height: 1.4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(2.4.w),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline, color: Colors.orange, size: 5.w),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Repeated aggression detected',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Friday',
                          style: TextStyle(fontSize: 16.sp, color: Colors.black45),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Emily was involved in repeated aggressive behavior in class over last few days.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black54,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
