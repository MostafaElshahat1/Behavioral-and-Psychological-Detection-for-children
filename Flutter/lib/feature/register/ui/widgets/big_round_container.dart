// feature/register/ui/widgets/big_round_container.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterBigRoundContainer extends StatelessWidget {
  const RegisterBigRoundContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: 38.h,
        decoration: BoxDecoration(
          color: const Color(0xFFCFE1F4),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.w),
            bottomRight: Radius.circular(50.w),
          ),
        ),
      ),
    );
  }
}
