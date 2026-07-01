// feature/sellect roll/ui/widgets/select_role_content.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/sellect%20roll/ui/widgets/role_card.dart';
import 'package:sizer/sizer.dart';

class SelectRoleContent extends StatelessWidget {
  const SelectRoleContent({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
    required this.onNext,
  });

  final String? selectedRole;
  final ValueChanged<String> onRoleSelected;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(6),
        SizedBox(height: 1.2.h),
        Center(
          child: Text(
            'Select Role',
            style: GoogleFonts.poppins(
              fontSize: 26.px,
              fontWeight: FontWeight.w600,
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
              color: Colors.black54,
            ),
          ),
        ),
        SizedBox(height: 3.5.h),
        Row(
          children: [
            Expanded(
              child: RoleCard(
                image: 'assets/student_image.png',
                selected: selectedRole == 'student',
                onTap: () => onRoleSelected('student'),
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: RoleCard(
                image: 'assets/parent_image.png',
                selected: selectedRole == 'parent',
                onTap: () => onRoleSelected('parent'),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: selectedRole == null ? null : onNext,
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
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
