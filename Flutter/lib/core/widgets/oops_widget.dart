// core/widgets/oops_widget.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OopsWidget extends StatelessWidget {
  const OopsWidget({super.key, this.errorMessage});
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/shy.png"),
        SizedBox(height: 2.h),
        const Text(
          "Oops!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.h),
        Text(
          errorMessage ?? "Something went wrong. Please try again later.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
