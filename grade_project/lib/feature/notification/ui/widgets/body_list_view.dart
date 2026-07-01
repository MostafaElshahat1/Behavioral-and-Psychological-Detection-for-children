// feature/notification/ui/widgets/body_list_view.dart

import 'package:flutter/material.dart';
import 'package:grade_project/feature/notification/ui/notification_screen.dart';
import 'package:grade_project/feature/notification/ui/widgets/date_devider.dart';
import 'package:grade_project/feature/notification/ui/widgets/notification_card.dart';
import 'package:sizer/sizer.dart';

class BodyListView extends StatelessWidget {
  const BodyListView({
    super.key,
    required this.todayItems,
    required this.yesterdayItems,
  });

  final List<NotificationItem> todayItems;
  final List<NotificationItem> yesterdayItems;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const DateDivider(label: 'today'),
          SizedBox(height: 1.2.h),
          ...todayItems.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: NotificationCard(item: item),
            ),
          ),
          SizedBox(height: 0.4.h),
          const DateDivider(label: 'yesterday'),
          SizedBox(height: 1.2.h),
          ...yesterdayItems
              .map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: NotificationCard(item: item),
                ),
              ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
