// feature/quistions/ui/2ans/widgets/qustion_text.dart


import 'package:flutter/material.dart';
import 'package:grade_project/feature/quistions/ui/2ans/questions2ans_screen.dart';
import 'package:sizer/sizer.dart';


class QustionText extends StatelessWidget {
  const QustionText({super.key, required this.widget});

  final QuestionsScreen2ans widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.question,
      style: TextStyle(
        fontSize: 21.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF23252B),
        height: 1.35,
      ),
    );
  }
}
