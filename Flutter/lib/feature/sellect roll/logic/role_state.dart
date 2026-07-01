// feature/sellect roll/logic/role_state.dart
part of 'role_cubit.dart';

abstract class RoleState {}

class RoleUnselected extends RoleState {}

class RoleInitial extends RoleUnselected {}

class RoleSelected extends RoleState {
  final String role;

  RoleSelected({required this.role});
}
