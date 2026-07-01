// feature/login/ui/widgets/eschool_container.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EschoolContainer extends StatelessWidget {
  const EschoolContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'E - SCHOOL',
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF1F429E),
      ),
    );
  }
}
