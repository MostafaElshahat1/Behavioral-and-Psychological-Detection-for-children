// feature/parent pages/welcome back/ui/home_select/ui/widgets/upper_page_strings.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class UpperPageString extends StatelessWidget {
  const UpperPageString({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Select Role',
            style: GoogleFonts.poppins(
              fontSize: 26.px,
              fontWeight: FontWeight.w600,
              //  letterSpacing: 1,
              color: Colors.black,
            ),
          ),
        ),
        verticalSpace(0.06.h),
        Center(
          child: Text(
            'please select role to continue',
            style: GoogleFonts.poppins(
              fontSize: 13.px,
              fontWeight: FontWeight.w600,
              //  letterSpacing: 1,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
