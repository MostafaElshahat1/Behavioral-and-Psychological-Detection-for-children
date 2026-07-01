// feature/risk/ui/risk_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/risk/ui/widgets/alerts_card.dart';
import 'package:grade_project/feature/risk/ui/widgets/counselor_contact_card.dart';
import 'package:grade_project/feature/risk/ui/widgets/risk_card.dart';
import 'package:grade_project/feature/risk/ui/widgets/risk_header.dart';
import 'package:sizer/sizer.dart';

class RiskScreen extends StatelessWidget {
  const RiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(IRouts.settingScreen),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RiskHeader(),
                RiskCard(data: const [6, 7.2, 6.8, 6.0, 5.4]),

                SizedBox(height: 2.h),

                const AlertsCard(),

                SizedBox(height: 2.h),

                const CounselorContactCard(),

                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
