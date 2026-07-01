// feature/image reports/ui/widgets/back_notification_row.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BackNotificationRow extends StatelessWidget {
  const BackNotificationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Icon(Icons.notifications, color: const Color(0xFF1F5F91), size: 25.sp),
      ],
    );
  }
}
