// feature/register/ui/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/register/logic/register_cubit.dart';
import 'package:grade_project/feature/register/ui/widgets/big_round_container.dart';
import 'package:grade_project/feature/register/ui/widgets/home_image.dart';
import 'package:grade_project/feature/register/ui/widgets/register_build_input.dart';
import 'package:grade_project/feature/register/ui/widgets/register_button.dart';
import 'package:grade_project/feature/register/ui/widgets/register_title.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roleIdController = TextEditingController();
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
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _roleIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          _showLoadingDialog(context);
        } else {
          _hideLoadingDialog(context);

          if (state is RegisterSuccess) {
            context.pushNamedAndRemoveUntil(
              IRouts.loginScreen,
              predicate: (route) => route.isFirst,
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                  const RegisterBigRoundContainer(),
                  const RegisterHomeImage(),
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
                          const RegisterTitle(),
                          SizedBox(height: 2.h),
                          RegisterBuildInput(
                            controller: _userNameController,
                            hint: 'userName',
                            icon: Icons.person_outline,
                          ),
                          SizedBox(height: 2.h),
                          RegisterBuildInput(
                            controller: _emailController,
                            hint: 'email',
                            icon: Icons.email_outlined,
                          ),
                          SizedBox(height: 2.h),
                          RegisterBuildInput(
                            controller: _passwordController,
                            hint: 'password',
                            icon: Icons.lock,
                            obscure: true,
                          ),
                          SizedBox(height: 2.h),
                          RegisterBuildInput(
                            controller: _phoneController,
                            hint: 'phone number',
                            icon: Icons.phone,
                          ),
                          SizedBox(height: 2.h),
                          RegisterBuildInput(
                            controller: _roleIdController,
                            hint: 'role ID',
                            icon: Icons.badge_outlined,
                          ),
                          SizedBox(height: 4.h),
                          RegisterButton(
                            onPressed: () {
                              final userName = _userNameController.text.trim();
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();
                              final phoneNumber = _phoneController.text.trim();
                              final roleIdText = _roleIdController.text.trim();
                              final roleID = int.tryParse(roleIdText) ?? 0;
              
                              context.read<RegisterCubit>().register(
                                userName: userName,
                                email: email,
                                password: password,
                                phoneNumber: phoneNumber,
                                roleID: roleID,
                              );
                            },
                          ),
                          SizedBox(height: 8.h),
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
}
