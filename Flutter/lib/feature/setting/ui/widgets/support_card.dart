// feature/setting/ui/widgets/support_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/setting/ui/widgets/setting_card.dart';
import 'package:sizer/sizer.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Support',
              style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 28.sp,
              color: Colors.black26,
            ),
          ),
          Divider(height: 0, thickness: 0.5, color: Colors.grey.shade200),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.0.w),
                  child: Icon(Icons.email, size: 20.sp, color: Colors.black54),
                ),
                horezontalSpace(1.5),
                Text('Contact Us', style: TextStyle(fontSize: 18.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
