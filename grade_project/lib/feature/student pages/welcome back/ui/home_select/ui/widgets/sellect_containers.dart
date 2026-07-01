// feature/parent pages/welcome back/ui/home_select/ui/widgets/sellect_containers.dart

import 'package:flutter/material.dart';
import 'package:grade_project/feature/sellect%20roll/ui/widgets/role_card.dart';
import 'package:sizer/sizer.dart';

class SellectContainers extends StatelessWidget {
  const SellectContainers({
    super.key,
    this.selectedRole,
    required this.onRoleSelected,
  });
  final String? selectedRole;
  final ValueChanged<String> onRoleSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.all(2.h),
            child: RoleCard(
              image: 'assets/home_selectscreen_overview.png',
              selected: selectedRole == 'overview',
              onTap: () {
                onRoleSelected('overview');
              },
            ),
          ),
          SizedBox(width: 6.w),
          Padding(
            padding: EdgeInsets.all(2.h),
            child: Stack(
              children: [
                RoleCard(
                  image: 'assets/home_selectscreen_report.png',
                  selected: selectedRole == 'reports',
                  onTap: () {
                    onRoleSelected('reports');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.h),
            child: RoleCard(
              image: 'assets/home_selectscreen_settings.png',
              selected: selectedRole == 'settings',
              onTap: () {
                onRoleSelected('settings');
              },
            ),
          ),
        ],
      ),
    );
  }
}
