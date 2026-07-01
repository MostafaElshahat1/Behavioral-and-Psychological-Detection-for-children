// feature/onpord/ui/widgets/get_start_button.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:sizer/sizer.dart';

class GetStartButton extends StatelessWidget {
  const GetStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80.w,
        child: ElevatedButton(
          onPressed: () {
            context.pushReplacementNamed(IRouts.selectRoleScreen);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4E8EC0),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.sp),
            ),
          ),

          child: Text(
            'GET STARTED',
            style: GoogleFonts.poppins(
              fontSize: 26.px,
              fontWeight: FontWeight.w600,
              //  letterSpacing: 1,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
