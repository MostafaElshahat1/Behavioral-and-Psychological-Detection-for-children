// feature/login/ui/login_screen.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// feature/login/ui/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/login/logic/login_cubit.dart';
import 'package:grade_project/feature/login/ui/widgets/big_round_countainer.dart';
import 'package:grade_project/feature/login/ui/widgets/eschool_container.dart';
import 'package:grade_project/feature/login/ui/widgets/home_image.dart';
import 'package:grade_project/feature/login/ui/widgets/login_build_input.dart';
import 'package:grade_project/feature/login/ui/widgets/login_button.dart';
import 'package:grade_project/feature/sellect%20roll/logic/role_cubit.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoadingDialogVisible = false;

  void _showLoadingDialog(BuildContext context) {
    if (_isLoadingDialogVisible) return;
    _isLoadingDialogVisible = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    ).then((_) {
      _isLoadingDialogVisible = false;
    });
  }

  void _hideLoadingDialog(BuildContext context) {
    if (!_isLoadingDialogVisible) return;
    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (_) {}
    _isLoadingDialogVisible = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          _showLoadingDialog(context);
        } else {
          _hideLoadingDialog(context);

          if (state is LoginSuccess) {
            final roleCubit = context.read<RoleCubit>();
            final savedRole = await roleCubit.getSavedRoleFromPrefs();
            final apiRole = state.loginResponse.result?.role;

            // Check if roles match
            if (savedRole.isNotEmpty &&
                apiRole != null &&
                savedRole != apiRole &&context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Role mismatch error! Please login again.'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final role = savedRole.isNotEmpty
                ? savedRole
                : (apiRole ?? 'student');

            final targetRoute = switch (role) {
              'parent' => IRouts.homeSelectScreen,
              'student' => IRouts.welcomeBackStudentScreen,
              _ => IRouts.onpordingScreen,
            };

          if (context.mounted){
            context.pushNamedAndRemoveUntil(
              targetRoute,
              predicate: (route) => route.isFirst,
            );
           }
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorModel.errorMessages!.join(",").toString())));
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  BigRoundContainer(),
                  HomeImage(),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          EschoolContainer(),
                          SizedBox(height: 1.h),
                          LoginBuildInput(
                            controller: _emailController,
                            hint: 'Username',
                            icon: Icons.badge_outlined,
                          ),
                          SizedBox(height: 2.h),
                          LoginBuildInput(
                            controller: _passwordController,
                            hint: 'Password',
                            icon: Icons.lock,
                            obscure: true,
                          ),
                          SizedBox(height: 4.h),
                          LoginButton(
                            onPressed: () {
                              final userName = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              context.read<LoginCubit>().login(
                                userName: userName,
                                password: password,
                              );
                            },
                          ),
                          SizedBox(height: 1.h),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       "Don't have an account? ",
                          //       style: TextStyle(
                          //         fontSize: 15.sp,
                          //         color: Colors.grey[700],
                          //       ),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         context.pushNamed(IRouts.registerScreen);
                          //       },
                          //       child: Text(
                          //         'register',
                          //         style: TextStyle(
                          //           fontSize: 15.sp,
                          //           color: const Color(0xFF6EA9D5),
                          //           fontWeight: FontWeight.w700,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                         
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //   Widget buildInput({

  //   }) {
  //     return BuildInput();
  //   }
}
