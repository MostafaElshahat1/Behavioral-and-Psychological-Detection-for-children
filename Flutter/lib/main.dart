// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:grade_project/core/helper/bloc_observer.dart';
import 'package:grade_project/core/routing/app_router.dart';
import 'package:grade_project/grade.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Bloc.observer = AddBlocObserver();
  await checkedLogedIn();
  FlutterNativeSplash.remove();

  runApp(GradeProject(approuting: IAppRouter()));
}
