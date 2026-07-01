// feature/parent pages/welcome back/ui/widgets/data_private_container.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DataPrivateContainer extends StatelessWidget {
  const DataPrivateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 9.5.w,
                height: 9.5.w,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Icon(
                  Icons.verified_user,
                  color: const Color(0xFF2F6A9B),
                  size: 23.5.sp,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  'Your data is private\nand securely protected',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF23252B),
                    height: 1.35,
                  ),
                ),
              ),
              Icon(Icons.verified_user, color: Colors.grey, size: 31.sp),
            ],
          ),
          SizedBox(height: 1.1.h),
          Divider(height: 1, color: Colors.black.withOpacity(0.25)),
        ],
      ),
    );
  }
}
