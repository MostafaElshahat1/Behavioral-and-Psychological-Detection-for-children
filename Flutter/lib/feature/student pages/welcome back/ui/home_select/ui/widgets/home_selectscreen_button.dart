// feature/parent pages/welcome back/ui/home_select/ui/widgets/home_selectscreen_button.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:sizer/sizer.dart';

class HomeSelectScreenButton extends StatelessWidget {
  const HomeSelectScreenButton({super.key, required this.selectedRole});

  final String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectedRole == null
            ? null
            : () {
                if (selectedRole == 'overview') {
                  context.pushNamed(IRouts.riskScreen);
                  return;
                }
                if (selectedRole == 'reports') {
                  context.pushNamed(IRouts.report2Screen);
                  return;
                }
                if (selectedRole == 'settings') {
                  context.pushNamed(IRouts.settingScreen);
                }
              },
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: const Color(0xFF75ADD7),
          backgroundColor: const Color(0xFF3F83B8),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.sp),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.7.h),
          elevation: 3,
        ),
        child: Text(
          'NEXT',
          style: GoogleFonts.poppins(
            fontSize: 26.px,
            fontWeight: FontWeight.w600,
            //  letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
