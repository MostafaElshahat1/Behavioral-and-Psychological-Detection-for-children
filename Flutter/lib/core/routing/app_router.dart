// core/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/image%20procesing/image_analysis_model.dart';
import 'package:grade_project/feature/image%20procesing/image_in.dart';
import 'package:grade_project/feature/image%20procesing/image_out.dart';
import 'package:grade_project/feature/image%20procesing/imagequbit_cubit.dart';
import 'package:grade_project/feature/image%20reports/ui/image_reports_screen.dart';
import 'package:grade_project/feature/login/logic/login_cubit.dart';
import 'package:grade_project/feature/login/ui/login_screen.dart';
import 'package:grade_project/feature/notification/ui/notification_screen.dart';
import 'package:grade_project/feature/onpord/ui/onpord_screen.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/home_select/ui/home_select_screen.dart';
import 'package:grade_project/feature/student%20pages/welcome%20back/ui/welcomeback_student_screen.dart';
import 'package:grade_project/feature/quistions/logic/questions_cubit.dart';
import 'package:grade_project/feature/quistions/ui/questions_flow_screen.dart';
import 'package:grade_project/feature/register/logic/register_cubit.dart';
import 'package:grade_project/feature/register/ui/register_screen.dart';
import 'package:grade_project/feature/repeted/ui/repeted_screen.dart';
import 'package:grade_project/feature/report%20with%20date/report2_screen.dart';
import 'package:grade_project/feature/report%20with%20date/widgets/report2_alert_card.dart';
import 'package:grade_project/feature/report/logic/report_cubit.dart';
import 'package:grade_project/feature/report/ui/report_screen.dart';
import 'package:grade_project/feature/risk/ui/risk_screen.dart';
import 'package:grade_project/feature/sellect%20roll/logic/role_cubit.dart';
import 'package:grade_project/feature/sellect%20roll/ui/select_role_screen.dart';
import 'package:grade_project/feature/setting/ui/setting_screen.dart';
import 'package:grade_project/feature/thank%20you/thank_you_screen.dart';
import 'package:grade_project/feature/welcome%20back/ui/welcome%20back2/welcom3/welcome3_screen.dart';
import 'package:grade_project/feature/welcome%20back/ui/welcome%20back2/welcome_back2.dart';
import 'package:grade_project/feature/welcome%20back/ui/welcome_back.dart';

class IAppRouter {
  IAppRouter()
    : _roleCubit = RoleCubit()..loadSavedRole(),
      _imagequbitCubit = ImagequbitCubit();

  final RoleCubit _roleCubit;
  final ImagequbitCubit _imagequbitCubit;

  Widget _withLoginProviders() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
        BlocProvider<RoleCubit>.value(value: _roleCubit),
      ],
      child: const LoginScreen(),
    );
  }

  Widget _withRegisterProviders() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (_) => RegisterCubit()),
        BlocProvider<RoleCubit>.value(value: _roleCubit),
      ],
      child: const RegisterScreen(),
    );
  }

  Widget _withRoleProvider(Widget child) {
    return BlocProvider<RoleCubit>.value(value: _roleCubit, child: child);
  }

  Widget _withImageProvider() {
    return BlocProvider<ImagequbitCubit>.value(
      value: _imagequbitCubit,
      child: const ImageIn(),
    );
  }

  Widget _withQuestionsProvider({
    required int testId,
    VoidCallback? onFinished,
  }) {
    return BlocProvider<QuestionsCubit>(
      create: (_) => QuestionsCubit()..getQuestionsById(testId),
      child: QuestionsFlowScreen(testId: testId, onFinished: onFinished),
    );
  }

  Route? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case IRouts.onpordingScreen:
        return MaterialPageRoute(builder: (_) => const OnpordScreen());

      case IRouts.loginScreen:
        return MaterialPageRoute(builder: (_) => _withLoginProviders());

      case IRouts.selectRoleScreen:
        return MaterialPageRoute(
          builder: (_) => _withRoleProvider(const SelectRoleScreen()),
        );

      case IRouts.homeSelectScreen:
        return MaterialPageRoute(builder: (_) => const HomeSelectScreen());

      case IRouts.welcomeBackPage:
        return MaterialPageRoute(builder: (_) => const WelcomeBackPage());

      case IRouts.welcomeBack2Page:
        return MaterialPageRoute(builder: (_) => const WelcomeBack2Page());

      case IRouts.welcome3Screen:
        return MaterialPageRoute(builder: (_) => const Welcome3Screen());

      case IRouts.welcomeBackStudentScreen:
        return MaterialPageRoute(
          builder: (_) => const WelcomeBackStudentScreen(),
        );

      case IRouts.repeteScreen:
        return MaterialPageRoute(builder: (_) => const RepetedScreen());

      case IRouts.riskScreen:
        return MaterialPageRoute(builder: (_) => const RiskScreen());

      case IRouts.reportScreen:
        return MaterialPageRoute(builder: (_) => const ReportScreen());

      case IRouts.report2Screen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ReportCubit>(
            create: (context) => ReportCubit(),
            child: Report2Screen(),
          ),
        );

      case IRouts.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());

      case IRouts.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());

      case IRouts.imageReportsScreen:
        var arg = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ImageReportsScreen(report: arg as ReportCardModel),
        );

      case IRouts.imageInScreen:
        return MaterialPageRoute(builder: (_) => _withImageProvider());

      case IRouts.imageOutScreen:
        final args = settings.arguments;
        final result = args is ImageAnalyzeResult ? args : null;
        return MaterialPageRoute(builder: (_) => ImageOut(result: result));

      case IRouts.thankYouScreen:
        return MaterialPageRoute(builder: (_) => const ThankYouScreen());

      case IRouts.questionsScreen:
        final args = settings.arguments;

        int testId = 6;
        VoidCallback? onFinished;

        if (args is int) {
          testId = args;
        } else if (args is VoidCallback) {
          onFinished = args;
        } else if (args is Map<String, dynamic>) {
          final value = args['testId'];
          if (value is int) {
            testId = value;
          }

          final callback = args['onFinished'];
          if (callback is VoidCallback) {
            onFinished = callback;
          }
        }

        return MaterialPageRoute(
          builder: (_) =>
              _withQuestionsProvider(testId: testId, onFinished: onFinished),
        );

      case IRouts.registerScreen:
        return MaterialPageRoute(builder: (_) => _withRegisterProviders());

      default:
        return null;
    }
  }
}

// Backward-compatible alias so both IAppRouter and MyAppRouter work.
class MyAppRouter extends IAppRouter {}
