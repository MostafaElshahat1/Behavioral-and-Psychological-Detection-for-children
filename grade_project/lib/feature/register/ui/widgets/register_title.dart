// feature/register/ui/widgets/register_title.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Register',
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF1F429E),
      ),
    );
  }
}
