// feature/register/logic/register_state.dart
part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess(this.registerResponseModel, {required this.message});
final RegisterResponseModel registerResponseModel;
  final String message;
}

class RegisterFailure extends RegisterState {
  RegisterFailure(this.message);

  final String message;
}
