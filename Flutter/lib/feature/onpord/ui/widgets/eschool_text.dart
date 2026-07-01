// feature/onpord/ui/widgets/eschool_text.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EschoolText extends StatelessWidget {
  const EschoolText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'E - SCHOOL',
    
        style: TextStyle(
          fontSize: 32.px,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
          color: const Color(0xFF1F189D),
        ),
      ),
    );
  }
}
