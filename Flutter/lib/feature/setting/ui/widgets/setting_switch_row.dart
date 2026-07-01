// feature/setting/ui/widgets/setting_switch_row.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class SettingSwitchRow extends StatelessWidget {
  const SettingSwitchRow({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.titleStyle,
    this.subtitleStyle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

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
                title,
                style:
                    titleStyle ??
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
              ),
              verticalSpace(2),
              if (subtitle != null) ...[
                SizedBox(height: 0.5.h),
                Text(
                  subtitle!,
                  style:
                      subtitleStyle ??
                      TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ],
          ),
        ),
        Transform.scale(
          scale: 3.5.sp,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: Colors.blue.shade400,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
