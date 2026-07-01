// feature/notification/ui/widgets/back_arow.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BackArow extends StatelessWidget {
  const BackArow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).maybePop(),
      child: Icon(
        Icons.arrow_back_rounded,
        size: 30.sp,
        color: const Color(0xFF4A4A4A),
      ),
    );
  }
}
