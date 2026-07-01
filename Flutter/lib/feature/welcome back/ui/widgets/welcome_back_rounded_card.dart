// feature/welcome back/ui/widgets/welcome_back_rounded_card.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackRoundedCard extends StatelessWidget {
  final Widget child;
  const WelcomeBackRoundedCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
