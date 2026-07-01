// feature/quistions/ui/4ans/questions4ans_screen.dart

import 'package:flutter/material.dart';
import 'package:grade_project/feature/quistions/ui/4ans/widgets/answer_button.dart';
import 'package:grade_project/feature/quistions/ui/4ans/widgets/qustion_button.dart';
import 'package:grade_project/feature/quistions/ui/4ans/widgets/qustion_text.dart';
import 'package:grade_project/feature/quistions/ui/4ans/widgets/slider_row.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/widgets/data_private_container.dart';
import 'package:sizer/sizer.dart';

class QuestionsScreen4ans extends StatefulWidget {
  const QuestionsScreen4ans({
    super.key,
    this.currentStep = 1,
    this.totalSteps = 17,
    this.question =
        'How often have you been bullied in school in the past six months?',
    this.options = const [
      'Not at all ( Zero )',
      'Less than once a week',
      'More than once a week',
      'Most days',
    ],
    this.onNextTap,
    this.onAnswerChanged,
    this.isLastStep = false,
  });

  final int currentStep;
  final int totalSteps;
  final String question;
  final List<String> options;
  final VoidCallback? onNextTap;
  final ValueChanged<String>? onAnswerChanged;
  final bool isLastStep;

  @override
  State<QuestionsScreen4ans> createState() => _QuestionsScreen4ansState();
}

class _QuestionsScreen4ansState extends State<QuestionsScreen4ans> {
  String? _selectedAnswer;

  double get _progress {
    if (widget.totalSteps <= 0) {
      return 0;
    }
    return (widget.currentStep / widget.totalSteps).clamp(0, 1).toDouble();
  }

  void _selectAnswer(String value) {
    setState(() {
      _selectedAnswer = value;
    });
    widget.onAnswerChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(6.w, 2.2.h, 6.w, 19.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderRow4ans(
                      progress: _progress,
                      currentStep: widget.currentStep,
                      totalSteps: widget.totalSteps,
                    ),
                    SizedBox(height: 4.2.h),
                    Text(
                      'Qustion${widget.currentStep} :',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF23252B),
                      ),
                    ),
                    /**TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF23252B),
                      ), */
                    // SizedBox(height: 3.3.h),
                     QustionText4ans(question: widget.question),
                    SizedBox(height: 6.h),
                    ...List.generate(
                      widget.options.length,
                      (index) => AnswerButton4ans(
                        label: widget.options[index],
                        isSelected: _selectedAnswer == widget.options[index],
                        onTap: () => _selectAnswer(widget.options[index]),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    QustionButton4ans(
                      onNextTap: widget.onNextTap,
                      isLastStep: widget.isLastStep,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 1.h,
                right: 1.h,
                bottom: 0,
                child: DataPrivateContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
