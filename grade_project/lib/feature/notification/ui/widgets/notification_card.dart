// feature/notification/ui/widgets/notification_card.dart

import 'package:flutter/material.dart';
import 'package:grade_project/feature/notification/ui/notification_screen.dart';
import 'package:sizer/sizer.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    final NotificationPalette palette = paletteFor(item.level);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.55.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F8),
        borderRadius: BorderRadius.circular(4.3.w),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: palette.background,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.priority_high_rounded,
              size: 15.sp,
              color: palette.foreground,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1C1C1C),
                letterSpacing: -0.1,
              ),
            ),
          ),
          if (item.hasArrow)
            Icon(
              Icons.chevron_right_rounded,
              size: 22.sp,
              color: const Color(0xFF7A7A7A),
            ),
        ],
      ),
    );
  }

  NotificationPalette paletteFor(NotificationLevel level) {
    switch (level) {
      case NotificationLevel.success:
        return const NotificationPalette(
          foreground: Color(0xFF109545),
          background: Color(0xFFDDF8E8),
        );
      case NotificationLevel.warning:
        return const NotificationPalette(
          foreground: Color(0xFFCF8206),
          background: Color(0xFFFFEBCB),
        );
      case NotificationLevel.neutral:
        return const NotificationPalette(
          foreground: Color(0xFF727272),
          background: Color(0xFFE8E8E8),
        );
    }
  }
}
