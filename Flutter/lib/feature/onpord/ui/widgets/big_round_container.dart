// feature/onpord/ui/widgets/big_round_container.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BigRoundRectangle extends StatelessWidget {
  const BigRoundRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF4E8EC0).withOpacity(0.1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70.sp),
            bottomRight: Radius.circular(70.sp),
          ),
        ),
      ),
    );
  }
}
