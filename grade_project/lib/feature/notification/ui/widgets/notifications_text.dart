// feature/notification/ui/widgets/notifications_text.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationText extends StatelessWidget {
  const NotificationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'notifications',
      style: TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF181818),
        letterSpacing: -0.2,
      ),
    );
  }
}
