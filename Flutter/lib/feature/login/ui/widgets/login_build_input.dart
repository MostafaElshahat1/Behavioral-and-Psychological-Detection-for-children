// feature/login/ui/widgets/login_build_input.dart

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginBuildInput extends StatelessWidget {
  const LoginBuildInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.2.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 16.sp, color: const Color(0xFF555555)),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 2.1.h),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16.sp, color: const Color(0xFF9A9A9A)),
          prefixIcon: Icon(icon, color: const Color(0xFF9A9A9A), size: 20.sp),
        ),
      ),
    );
  }
}
