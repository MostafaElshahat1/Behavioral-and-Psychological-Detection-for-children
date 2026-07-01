// feature/login/logic/login_state.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// feature/login/logic/login_state.dart
part of 'login_cubit.dart';

/// Plain (non-freezed) states for `LoginCubit`.
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({
    required this.loginResponse,
    required this.message,
    required this.token,
    required this.userId,
  });
  final LoginResponse loginResponse;
  final String message;
  final String token;
  final int userId;
}

class LoginFailure extends LoginState {
  LoginFailure(this.errorModel);

  final ErrorModel errorModel;
}
