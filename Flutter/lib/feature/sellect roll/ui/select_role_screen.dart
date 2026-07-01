// feature/sellect roll/ui/select_role_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/sellect%20roll/logic/role_cubit.dart';
import 'package:grade_project/feature/sellect%20roll/ui/widgets/select_role_content.dart';
import 'package:sizer/sizer.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key, this.onNext});

  final VoidCallback? onNext;

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoleCubit>().clearRole();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleCubit, RoleState>(
      builder: (context, state) {
        final selectedRole = state is RoleSelected ? state.role : null;

        return Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.25,
                    child: Image.asset(
                      'assets/onpord_back_image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  child: SelectRoleContent(
                    selectedRole: selectedRole,
                    onRoleSelected: (role) {
                      context.read<RoleCubit>().selectRole(role);
                    },
                    onNext:
                        widget.onNext ??
                        () async {
                          if (context.mounted) {
                            context.pushReplacementNamed(IRouts.loginScreen);
                          }
                        },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
