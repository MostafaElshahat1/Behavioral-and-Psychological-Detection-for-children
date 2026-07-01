// feature/student pages/welcome back/ui/welcomeback_student_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/widgets/circuit_painter.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/widgets/data_private_container.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/widgets/start_survey_container.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/widgets/support_container.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/widgets/welcome_back_row.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackStudentScreen extends StatelessWidget {
  const WelcomeBackStudentScreen({
    super.key,
    this.onStartSurveyTap,
    this.onSupportTap,
    this.onContactTap,
  });

  final VoidCallback? onStartSurveyTap;
  final VoidCallback? onSupportTap;
  final VoidCallback? onContactTap;

  @override
  Widget build(BuildContext context) {
    onSettingsTap() {
      context.pushNamed(IRouts.settingScreen);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: SizedBox(
                    height: 20.h,
                    child: CustomPaint(painter: CircuitPainter()),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 22.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeBackRow(onSettingsTap: onSettingsTap),
                    SizedBox(height: 23.h),
                    StartServayContainer(
                      onStartSurveyTap: () => context.pushNamed(
                        IRouts.questionsScreen,
                        arguments: () => context.pushNamed(IRouts.repeteScreen),
                      ),
                    ),
                    SizedBox(height: 8.5.h),
                    SupportContainer(
                      onSupportTap: onSupportTap,
                      onContactTap: onContactTap,
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
              Positioned(
                left: 3.w,
                right: 3.w,
                bottom: 1.w,
                child: const DataPrivateContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
