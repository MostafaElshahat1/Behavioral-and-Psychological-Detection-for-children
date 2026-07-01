// feature/setting/ui/widgets/notifications_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/setting/ui/widgets/setting_card.dart';
import 'package:grade_project/feature/setting/ui/widgets/setting_switch_row.dart';
import 'package:sizer/sizer.dart';

class NotificationsCard extends StatelessWidget {
  const NotificationsCard({
    super.key,
    required this.notifications,
    required this.onNotificationsChanged,
  });

  final bool notifications;
  final ValueChanged<bool> onNotificationsChanged;

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      child: SettingSwitchRow(
        title: 'Notifications',
        value: notifications,
        onChanged: onNotificationsChanged,
        titleStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
