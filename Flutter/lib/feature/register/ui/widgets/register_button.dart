// feature/register/ui/widgets/register_button.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({required this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 6.3.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        gradient: const LinearGradient(
          colors: [Color(0xFF6EA9D5), Color(0xFF3A6F9D)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ),
        ),
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
