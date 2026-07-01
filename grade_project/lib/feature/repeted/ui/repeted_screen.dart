// feature/repeted/ui/repeted_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/repeted/ui/widgets/repeated_contact_button.dart';
import 'package:grade_project/feature/repeted/ui/widgets/repeated_details_card.dart';
import 'package:grade_project/feature/repeted/ui/widgets/repeated_header.dart';
import 'package:sizer/sizer.dart';

class RepetedScreen extends StatelessWidget {
  const RepetedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RepeatedHeader(),

              SizedBox(height: 3.h),

              const Expanded(child: RepeatedDetailsCard()),
              verticalSpace(2),
              const RepeatedContactButton(),
            ],
          ),
        ),
      ),
    );
  }
}
