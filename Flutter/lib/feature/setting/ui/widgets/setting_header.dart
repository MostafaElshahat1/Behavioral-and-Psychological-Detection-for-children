// feature/setting/ui/widgets/setting_header.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, size: 22.sp, color: Colors.black87),
        ),
        SizedBox(width: 3.w),
        Text(
          'Settings & Consent',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
