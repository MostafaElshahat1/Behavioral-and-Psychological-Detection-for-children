// feature/onpord/ui/widgets/upper_contaioner.dart

import 'package:flutter/material.dart';
import 'package:grade_project/feature/onpord/ui/widgets/big_round_container.dart';
import 'package:sizer/sizer.dart';

class UpperContainer extends StatelessWidget {
  const UpperContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.h),
        color: Colors.white,
        // gradient: const LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [Color(0xFF4FC3A1), Color(0xFF4E8EC0)],
        // ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -7.h,
            right: 0.w,
            left: 0.w,
            child: Image.asset(
              "assets/g1 (2).png",
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),
          BigRoundRectangle(),
          Positioned(
            top: 6.h,
            right: 10.w,
            left: 10.w,
            child: Image.asset(
              "assets/onpord_home_new.png",
              fit: BoxFit.contain,
              height: 28.h,
            ),
          ),
        ],
      ),
    );
  }
}
