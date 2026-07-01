// feature/setting/ui/widgets/consent_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/setting/ui/widgets/setting_card.dart';
import 'package:grade_project/feature/setting/ui/widgets/setting_switch_row.dart';
import 'package:sizer/sizer.dart';

class ConsentCard extends StatelessWidget {
  const ConsentCard({
    super.key,
    required this.consent,
    required this.parental,
    required this.onConsentChanged,
    required this.onParentalChanged,
  });

  final bool consent;
  final bool parental;
  final ValueChanged<bool> onConsentChanged;
  final ValueChanged<bool> onParentalChanged;

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingSwitchRow(
            title: 'Consent',
            value: consent,
            onChanged: onConsentChanged,
            titleStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          Divider(height: 2.h, thickness: 0.5, color: Colors.grey.shade200),
          SettingSwitchRow(
            title: 'Parental consent given',
            subtitle: 'Your summaries will be shared with authorized parties.',
            value: parental,
            onChanged: onParentalChanged,
            titleStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w400),
            subtitleStyle: TextStyle(fontSize: 16.5.sp, color: Colors.black54),
          ),
          SizedBox(height: 1.h),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Review privacy policy',
              style: TextStyle(fontSize: 16.5.sp, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
