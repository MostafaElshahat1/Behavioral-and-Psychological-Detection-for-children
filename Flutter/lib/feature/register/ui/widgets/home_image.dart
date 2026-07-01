// feature/register/ui/widgets/home_image.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterHomeImage extends StatelessWidget {
  const RegisterHomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2.5.h,
      left: 0,
      right: 0,
      child: Center(
        child: Image.asset(
          'assets/onpord_home_new.png',
          height: 30.h,
          width: 50.w,
        ),
      ),
    );
  }
}
