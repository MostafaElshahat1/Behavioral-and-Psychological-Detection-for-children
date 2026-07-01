// feature/quistions/ui/4ans/widgets/qustion_text.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QustionText4ans extends StatelessWidget {
  const QustionText4ans({super.key, required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    return Text(

      question,
      style: TextStyle(
        fontSize: 21.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF23252B),
        height: 1.35,
      ),
    );
  }
}
/** Text(
                      'Q) ${widget.currentStep}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF23252B),
                      ),
                    ), */
