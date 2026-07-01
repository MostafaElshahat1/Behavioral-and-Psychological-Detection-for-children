// feature/setting/ui/widgets/setting_card.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 6)),
        ],
      ),
      child: child,
    );
  }
}
