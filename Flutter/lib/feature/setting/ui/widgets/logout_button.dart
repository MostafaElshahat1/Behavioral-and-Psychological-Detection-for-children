// feature/setting/ui/widgets/logout_button.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 244, 242, 242),
          elevation: 2.h,
          shadowColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 1.5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.sp),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'Logout',
          style: TextStyle(
            fontSize: 20.sp,
            color: const Color.fromARGB(255, 229, 37, 24),
          ),
        ),
      ),
    );
  }
}
