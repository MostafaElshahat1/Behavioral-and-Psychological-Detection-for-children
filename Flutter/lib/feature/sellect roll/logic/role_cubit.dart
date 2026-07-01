// feature/sellect roll/logic/role_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:grade_project/core/helper/constance_helper.dart';
import 'package:grade_project/core/helper/shared_prefrance_helper.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  RoleCubit() : super(RoleUnselected());

  String _currentRole = '';

  String get currentRole => _currentRole;

  Future<String> getSavedRoleFromPrefs() async {
    final savedRole = (await SharedPrefHelper.getString(
      SharedPrefranceKeys.userRole,
    )).trim().toLowerCase();
    _currentRole = savedRole;
    return savedRole;
  }

  /// حفظ الدور المختار
  Future<void> selectRole(String role) async {
    final normalizedRole = role.trim().toLowerCase();
    final savedRole = (await SharedPrefHelper.getString(
      SharedPrefranceKeys.userRole,
    )).trim().toLowerCase();

    _currentRole = normalizedRole;
    emit(RoleSelected(role: normalizedRole));

    // نحدّث التخزين فقط عند تغيير الدور فعلاً.
    if (savedRole != normalizedRole) {
      await SharedPrefHelper.setData(
        SharedPrefranceKeys.userRole,
        normalizedRole,
      );
    }
  }

  /// قراءة الدور المحفوظ
  Future<void> loadSavedRole() async {
    final savedRole = await getSavedRoleFromPrefs();
    if (savedRole.isNotEmpty) {
      //print("Loaded saved role: $savedRole =========");
      emit(RoleSelected(role: savedRole));
    } else {
      //print("No saved role found.=========");
      emit(RoleUnselected());
    }
  }

  /// مسح الدور
  Future<void> clearRole() async {
    _currentRole = '';
    emit(RoleUnselected());
    await SharedPrefHelper.removeData(SharedPrefranceKeys.userRole);
  }
}
