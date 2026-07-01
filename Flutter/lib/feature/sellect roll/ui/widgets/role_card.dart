// feature/sellect roll/ui/widgets/role_card.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({super.key, 
    // required this.label,
    required this.image,
    required this.selected,
    required this.onTap,
  });

  // final String label;
  final String image;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.sp),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.sp),
        onTap: onTap,
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 0.8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
            border: Border.all(
              color: selected ? const Color(0xFF3F83B8) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                image,
                
                height: 20.h,
                width: 30.w,
                color: const Color(0xFF4C77A9),
              ),
              // SizedBox(height: 1.2.h),
              // Text(
              //   label,
              //   style: TextStyle(
              //     color: const Color(0xFF2F5F95),
              //     fontSize: 18.sp,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
