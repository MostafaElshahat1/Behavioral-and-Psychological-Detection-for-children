// feature/risk/ui/widgets/risk_header.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:sizer/sizer.dart';

class RiskHeader extends StatelessWidget {
  const RiskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Sarah,',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 0.6.h),
              Text(
                'emily861@example.com',
                style: TextStyle(fontSize: 17.sp, color: Colors.black54),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(IRouts.report2Screen);
          },
          child: Icon(Icons.notifications, size: 26.sp, color: Colors.black54),
        ),
      ],
    );
  }
}
