// feature/repeted/ui/widgets/repeated_contact_button.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/core/widgets/app_text_button.dart';
import 'package:sizer/sizer.dart';

class RepeatedContactButton extends StatelessWidget {
  const RepeatedContactButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MyTextButton(
      buttonhight: 8,
      buttonwidth: null,
      buttonText: 'Contact School',
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      onpressed: () {
        context.pushNamed(IRouts.reportScreen);
      },
      borderRadius: 12.w,
      backGroundColor: const Color(0xFF4B88C6),
    );
  }
}
