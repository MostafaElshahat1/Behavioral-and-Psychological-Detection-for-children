// feature/register/logic/register_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:grade_project/core/helper/constance_helper.dart';
import 'package:grade_project/feature/register/data/model/register_requst_model.dart';
import 'package:grade_project/feature/register/data/model/register_response_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<RegisterResponseModel?> register({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required int roleID,
  }) async {
    emit(RegisterLoading());
    try {
      final request = RegisterRequestModel(
        userName: userName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        roleID: roleID,
      );

      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 25),
          headers: {'Content-Type': 'application/json'},
        ),
      );

      final response = await dio.post(
        '$baseUrl/user/register',
        data: request.toJson(),
      );

      final responseData = response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : Map<String, dynamic>.from(response.data as Map);
      final model = RegisterResponseModel.fromJson(responseData);

      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        emit(RegisterSuccess(model, message: 'Registered successfully'));
      } else {
        //print("object--*******//---${model.errorMessage}");
        emit(RegisterFailure(model.errorMessage));
      }

      return model;
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final model = RegisterResponseModel.fromJson(data);
        emit(RegisterFailure(model.errorMessage));
        return model;
      }

      final message =
          e.response?.statusMessage ?? e.message ?? 'Register failed';
      emit(RegisterFailure(message));
      return null;
    } catch (e) {
      //print("-------$e");

      emit(RegisterFailure(e.toString()));
      return null;
    }
  }

  // void registerStarted() => emit(RegisterLoading());

  // void registerSuccess({required String message}) =>
  //     emit(RegisterSuccess(message: message));

  // void registerFailure(String message) => emit(RegisterFailure(message));
}
