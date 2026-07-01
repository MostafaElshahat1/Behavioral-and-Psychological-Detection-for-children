// feature/student pages/welcome back/ui/home_select/ui/home_select_screen.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// feature/parent pages/welcome back/ui/home_select/ui/home_select_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/home_select/ui/widgets/home_selectscreen_button.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/home_select/ui/widgets/sellect_containers.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/home_select/ui/widgets/upper_page_strings.dart';
import 'package:sizer/sizer.dart';

class HomeSelectScreen extends StatefulWidget {
  const HomeSelectScreen({super.key, this.onNext});

  final VoidCallback? onNext;

  @override
  State<HomeSelectScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<HomeSelectScreen> {
  String? selectedRole;

  void _onRoleSelected(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                // Positioned(
                //   left: 0,
                //   right: 0,
                //   bottom: 0,
                //   child: Opacity(
                //     opacity: 0.25,
                //     child: Image.asset(
                //       'assets/onpord_back_image.jpg',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(7.2),
                      // IconButton(
                      //   padding: EdgeInsets.zero,
                      //   constraints: const BoxConstraints(),
                      //   onPressed: () => Navigator.of(context).maybePop(),
                      //   icon: Icon(
                      //     Icons.arrow_back,
                      //     size: 28.sp,
                      //     color: const Color(0xFF2C2C2C),
                      //   ),
                      // ),
                      // SizedBox(height: 1.2.h),
                      UpperPageString(),
                      verticalSpace(3.5),
                      SizedBox(height: 8.h),
                      SellectContainers(
                        selectedRole: selectedRole,
                        onRoleSelected: _onRoleSelected,
                      ),
                      verticalSpace(3.5),
                      HomeSelectScreenButton(selectedRole: selectedRole),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
