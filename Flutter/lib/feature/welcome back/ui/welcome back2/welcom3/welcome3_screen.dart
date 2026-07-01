// feature/welcome back/ui/welcome back2/welcom3/welcome3_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/welcome%20back/ui/welcome%20back2/welcom3/widgets/welcome3_content.dart';
import 'package:sizer/sizer.dart';

class Welcome3Screen extends StatelessWidget {
  const Welcome3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(IRouts.repeteScreen),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints.tight(Size(8.w, 8.w)),
                icon: Icon(
                  Icons.arrow_back,
                  size: 18.sp,
                  color: Colors.black87,
                ),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              SizedBox(height: 2.h),
              const Welcome3Content(),
            ],
          ),
        ),
      ),
    );
  }
}
