// feature/setting/ui/setting_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/helper/shared_prefrance_helper.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/setting/ui/widgets/consent_card.dart';
import 'package:grade_project/feature/setting/ui/widgets/logout_button.dart';
import 'package:grade_project/feature/setting/ui/widgets/notifications_card.dart';
import 'package:grade_project/feature/setting/ui/widgets/setting_header.dart';
import 'package:grade_project/feature/setting/ui/widgets/support_card.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool consent = true;
  bool parental = true;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(IRouts.welcomeBackPage),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SettingHeader(),

                SizedBox(height: 3.h),

                ConsentCard(
                  consent: consent,
                  parental: parental,
                  onConsentChanged: (value) => setState(() => consent = value),
                  onParentalChanged: (value) =>
                      setState(() => parental = value),
                ),

                SizedBox(height: 2.h),

                NotificationsCard(
                  notifications: notifications,
                  onNotificationsChanged: (value) =>
                      setState(() => notifications = value),
                ),

                SizedBox(height: 2.h),

                const SupportCard(),

                SizedBox(height: 15.h),

                LogoutButton(
                  onPressed: () {
                    SharedPrefHelper.clearAllSecuredData();
                    //print("Cleared all secured data token ???? ${SharedPrefHelper.getSecuredString(SharedPrefranceKeys.userToken).toString()}");
                    context.pushNamedAndRemoveUntil(
                      IRouts.onpordingScreen,
                      predicate: (route) => false,
                    );
                  },
                ),

                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
