// feature/onpord/ui/onpord_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/onpord/ui/widgets/eschool_text.dart';
import 'package:grade_project/feature/onpord/ui/widgets/get_start_button.dart';
import 'package:grade_project/feature/onpord/ui/widgets/upper_contaioner.dart';
import 'package:sizer/sizer.dart';

class OnpordScreen extends StatelessWidget {
  const OnpordScreen({super.key});

  // final VoidCallback? onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 0.w, left: 0.w, bottom: 0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 16),

                // const SizedBox(height: 24),
                UpperContainer(),
                verticalSpace(4),
                EschoolText(),
                verticalSpace(4),

                GetStartButton(),
                // const SizedBox(height: 8),
                Image.asset(
                  "assets/onpord_back_image.jpg",
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
