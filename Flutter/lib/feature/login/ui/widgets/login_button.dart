// feature/login/ui/widgets/login_button.dart

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grade_project/feature/login/logic/login_cubit.dart';
import 'package:sizer/sizer.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.onPressed,
    super.key,
    // required TextEditingController emailController,
    // required TextEditingController passwordController,
  });
  // : _emailController = emailController,
  //      _passwordController = passwordController;

  // final TextEditingController _emailController;
  // final TextEditingController _passwordController;
  final void Function()? onPressed;
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
        onPressed:onPressed,
        //  () {
        //   final userName = _emailController.text.trim();
        //   final password = _passwordController.text.trim();

        //   context.read<LoginCubit>().login(
        //     userName: userName,
        //     password: password,
        //   );
        // },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ),
        ),
        child: Text(
          'Log in',
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
