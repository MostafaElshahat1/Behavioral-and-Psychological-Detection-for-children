// feature/parent pages/welcome back/ui/widgets/welcome_back_row.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class WelcomeBackRow extends StatelessWidget {
  const WelcomeBackRow({super.key, required this.onSettingsTap});

  final VoidCallback? onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'welcome back!',
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF14161A),
                ),
              ),
              SizedBox(height: 0.6.h),
              Text(
                'Ready to check in ?',
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF82868E),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onSettingsTap,
          child: Padding(
            padding: EdgeInsets.all(0.8.h),
            child: Column(
              children: [
                Image.asset('assets/Vector.png'),
                SizedBox(height: 0.35.h),
                Text(
                  'settings',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF6E737A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
