// feature/notification/ui/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/notification/ui/widgets/back_arow.dart';
import 'package:grade_project/feature/notification/ui/widgets/body_list_view.dart';
import 'package:grade_project/feature/notification/ui/widgets/notifications_text.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NotificationItem> todayItems = [
      const NotificationItem(
        title: 'class entering',
        level: NotificationLevel.success,
      ),
      const NotificationItem(
        title: 'Low engagement in class',
        level: NotificationLevel.neutral,
        hasArrow: true,
      ),
      const NotificationItem(
        title: 'Sleeping in class',
        level: NotificationLevel.neutral,
        hasArrow: true,
      ),
      const NotificationItem(
        title: 'Repeated aggression',
        level: NotificationLevel.warning,
        hasArrow: true,
      ),
      const NotificationItem(
        title: 'Low engagement in class',
        level: NotificationLevel.neutral,
        hasArrow: true,
      ),
      const NotificationItem(
        title: 'class leaving',
        level: NotificationLevel.neutral,
      ),
    ];

    final List<NotificationItem> yesterdayItems = [
      const NotificationItem(
        title: 'class entering',
        level: NotificationLevel.success,
      ),
      const NotificationItem(
        title: 'Low engagement in class',
        level: NotificationLevel.neutral,
        hasArrow: true,
      ),
      const NotificationItem(
        title: 'Sleeping in class',
        level: NotificationLevel.neutral,
        hasArrow: true,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.8.h),
              BackArow(),
              SizedBox(height: 1.8.h),
              NotificationText(),
              SizedBox(height: 1.8.h),
              BodyListView(
                todayItems: todayItems,
                yesterdayItems: yesterdayItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.level,
    this.hasArrow = false,
  });

  final String title;
  final NotificationLevel level;
  final bool hasArrow;
}

class NotificationPalette {
  const NotificationPalette({
    required this.foreground,
    required this.background,
  });

  final Color foreground;
  final Color background;
}

enum NotificationLevel { success, neutral, warning }
