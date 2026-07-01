// grade.dart

import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/constance_helper.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/helper/shared_prefrance_helper.dart';
import 'package:grade_project/core/routing/app_router.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/sellect%20roll/logic/role_cubit.dart';
import 'package:sizer/sizer.dart';

String _loggedInInitialRoute = IRouts.onpordingScreen;

class GradeProject extends StatelessWidget {
  final IAppRouter? approuting;

  const GradeProject({super.key, required this.approuting});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          initialRoute: isLogedInUser
              ? _loggedInInitialRoute
              : IRouts.onpordingScreen,
          onGenerateRoute: approuting?.generateRouter,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

Future<void> checkedLogedIn() async {
  final roleCubit = RoleCubit();
  await roleCubit.loadSavedRole();

  String userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefranceKeys.userToken,
  );
  if (!userToken.isNullOrEmpty()) {
    isLogedInUser = true;
    final savedRole = roleCubit.currentRole;
    _loggedInInitialRoute = switch (savedRole) {
      'parent' => IRouts.homeSelectScreen,
      'student' => IRouts.welcomeBackStudentScreen,
      _ => IRouts.onpordingScreen,
    };
    //print(
    //   "==============user token is $userToken ======is login is {$isLogedInUser}",
    // );
  } else {
    isLogedInUser = false;
    _loggedInInitialRoute = IRouts.onpordingScreen;
  }
}
