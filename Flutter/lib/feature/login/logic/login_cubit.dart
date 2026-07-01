// feature/login/logic/login_cubit.dart

// feature/login/logic/login_cubit.dart
// import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/constance_helper.dart';
import 'package:grade_project/core/helper/shared_prefrance_helper.dart';
import 'package:grade_project/core/networking/dio_factory.dart';
import 'package:grade_project/core/networking/error_model.dart';
import 'package:grade_project/feature/login/data/model/get_student_id_model.dart';
import 'package:grade_project/feature/login/data/model/login_response_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  /// POSTs credentials to `http://pixel-vision.runasp.net/api/user/login`.
  /// Emits `LoginLoading`, then `LoginSuccess` or `LoginFailure`.
  /// Returns the parsed `LoginResponse` on success, or `null` on failure.
  Future<LoginResponse?> login({
    required String userName,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 25),
          headers: {'Content-Type': 'application/json'},
        ),
      );

      final resp = await dio.post(
        '$baseUrl/user/login',
        data: {'userName': userName, 'password': password},
      );
       final data = resp.data;
        final model = LoginResponse.fromJson(data);

      final status = resp.statusCode ?? 0;
      if (status >= 100) {
        data is Map<String, dynamic>
            ? resp.data as Map<String, dynamic>
            : Map<String, dynamic>.from(resp.data as Map);


        if (model.isSuccess && model.result != null) {

          // حفظ التوكن
          await setToken(model.result!.token);
          
          // حفظ الـ User ID
         int? studentId = await getStudentIdApi(
            parentId: model.result!.userId,
            token: model.result!.token,
          );
          await setUserId(studentId??2);

          // جلب الـ Student ID
          

          if (studentId != null) {
            await setStudentId(studentId);
          } else {
          }

          emit(
            LoginSuccess(
              loginResponse: model,
              message: model.result!.message,
              token: model.result!.token,
              userId: model.result!.userId,
            ),
          );
        } else {
          // final errors = model.errorMessages;
          // final msg = (errors != null && errors.isNotEmpty)
          //     ? errors.join(', ')
          //     : 'Login failed';
          emit(LoginFailure(ErrorModel(statusCode: model.statusCode, isSuccess: model.isSuccess,errorMessages: model.errorMessages)));
        }

        return model;
      } else {
        // final msg = 'Server error: $status - ${resp.data}';
          emit(LoginFailure(ErrorModel(statusCode: model.statusCode, isSuccess: model.isSuccess,errorMessages: model.errorMessages)));
        return null;
      }
    } catch (e) {
    // DioException  e = DioException(error: e);
    if(e is DioException ){
      DioException? dioError;

        emit(LoginFailure(ErrorModel(
        statusCode: dioError!.response?.data.statusCode,
        isSuccess: false,
        errorMessages: e.message.toString().split(" "),
      )));
    }
      // if ( e is DioException&& e.response != null) {
      //   final r = e.response!;
      //   msg = ;
      // } else if (e is DioException) {
      //   msg = 'Dio error: ${e.message}';
      // } else {
      //   msg = e.toString();
      // }
    
      return null;
    }
  }

  // ============================================================
  // Helper Methods
  // ============================================================

  Future<void> setToken(String token) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefranceKeys.userToken,
      token,
    );
    DioFactory.setTokenAfterLogin(token);
  }

  Future<void> setUserId(int userId) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefranceKeys.userId,
      userId.toString(),
    );
  }

  Future<int?> getStudentIdApi({
    required int parentId,
    required String token,
  }) async {
    
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 25),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      final response = await dio.get(
        '$baseUrl/Report/$parentId',
      );


      if (response.statusCode == 200) {
        // ✅ التحويل الصحيح باستخدام fromJson
        final parentStudentResponse = ParentStudentResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        if (parentStudentResponse.isSuccess) {
          final studentId = parentStudentResponse.result?.studentId;
          return studentId;
        } else {
          return null;
        }
      } else {
        return null;
      }
      
    } on DioException catch (e) {
      if (e.response != null) {
        
        if (e.response?.statusCode == 401) {
        } else if (e.response?.statusCode == 404) {
        }
      }
      return null;
      
    } catch (e) {
      return null;
    }
  }

  Future<void> setStudentId(int studentId) async {
    await SharedPrefHelper.setData(
      SharedPrefranceKeys.studentId,
      studentId,
    );
  }
  //parent
  //Parent@123

  // ============================================================
  // Convenience Methods (اختياري)
  // ============================================================
  
  // Future<void> logout() async {
  //   await SharedPrefHelper.removeKey(SharedPrefranceKeys.userToken);
  //   await SharedPrefHelper.removeKey(SharedPrefranceKeys.userId);
  //   await SharedPrefHelper.removeKey(SharedPrefranceKeys.studentId);
  //   emit(LoginInitial());
  // }
}
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:grade_project/core/helper/constance_helper.dart';
// import 'package:grade_project/core/helper/shared_prefrance_helper.dart';
// import 'package:grade_project/core/networking/dio_factory.dart';
// import 'package:grade_project/feature/login/data/model/get_student_id_model.dart';
// import 'package:grade_project/feature/login/data/model/login_response_model.dart';

// part 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitial());

//   /// POSTs credentials to `http://pixel-vision.runasp.net/api/user/login`.
//   /// Emits `LoginLoading`, then `LoginSuccess` or `LoginFailure`.
//   /// Returns the parsed `LoginResponse` on success, or `null` on failure.
//   Future<LoginResponse?> login({
//     required String userName,
//     required String password,
//   }) async {
//     emit(LoginLoading());
//     try {
//       final dio = Dio(
//         BaseOptions(
//           connectTimeout: const Duration(seconds: 20),
//           receiveTimeout: const Duration(seconds: 25),
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );

//       final resp = await dio.post(
//         //http://pixel-vision.runasp.net/api/user/register
//         '$baseUrl/user/login',
//         data: {'userName': userName, 'password': password},
//       );

//       final status = resp.statusCode ?? 0;
//       if (status >= 100) {
//         final data = resp.data is Map<String, dynamic>
//             ? resp.data as Map<String, dynamic>
//             : Map<String, dynamic>.from(resp.data as Map);

//         final model = LoginResponse.fromJson(data);

//         if (model.isSuccess && model.result != null) {
//           //print(':::::::;;;;;${model.result!.token}');
//           //print(';;;;;;;${model.result!}');
//           //print("Parent userId::::::: ${model.result!.userId}");

//           setToken(model.result!.token);
//           //print("Token for getStudentIdapi: -----------------------------");
//           int studentId = await getStudentIdapi(
//             model.result!.userId,
//             model.result!.token,
//           );
//           //print("Parent userId::::::: ${model.result!.userId}");
//           // //print("Parent userId::::::: ${model.result!.}");
//           //print("Student ID:::::::::: $studentId");

//           // //print("Error fetching student ID:::::: $e");

//           // getStudentIdapi(model.result!.userId);
//           emit(
//             LoginSuccess(
//               loginResponse: model,
//               message: model.result!.message,
//               token: model.result!.token,
//               userId: model.result!.userId,
//             ),
//           );
//         } else {
//           final errors = model.errorMessages;
//           final msg = (errors != null && errors.isNotEmpty)
//               ? errors.join(', ')
//               : 'Login failed';
//           emit(LoginFailure(msg));
//         }

//         return model;
//       } else {
//         final msg = 'Server error: $status - ${resp.data}';
//         emit(LoginFailure(msg));
//         return null;
//       }
//     } catch (e) {
//       String msg;
//       if (e is DioException && e.response != null) {
//         final r = e.response!;
//         msg = 'Dio error: ${e.message} - ${r.statusCode} ${r.data}';
//       } else if (e is DioException) {
//         msg = 'Dio error: ${e.message}';
//       } else {
//         msg = e.toString();
//       }
//       emit(LoginFailure(msg));
//       return null;
//     }
//   }

//   Future<void> setToken(String token) async {
//     await SharedPrefHelper.setSecuredString(
//       SharedPrefranceKeys.userToken,
//       token,
//     );
//     DioFactory.setTokenAfterLogin(token);
//   }

//   Future<void> setUserId(int userId) async {
//     await SharedPrefHelper.setSecuredString(
//       SharedPrefranceKeys.userId,
//       userId.toString(),
//     );
//   }

//   Future getStudentIdapi(int id, String token) async {
//     //print("Getting student ID for parent ID: $id");
//     try {
//       //print("Token for getStudentIdapi: -----------------------------");
//       final dio = Dio(
//         BaseOptions(
//           connectTimeout: const Duration(seconds: 20),
//           receiveTimeout: const Duration(seconds: 25),
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       Response<ParentStudentResponse> resp = await dio.get(
//         '$baseUrl/Report/$id',

//         ///api/Report/{id}
//       );

//       final status = resp.statusCode ?? 0;
//       if (status >= 100) {
//         final data = resp.data?.result?.studentId;

//         // final model = data['result'];
//         if (data != null) {
//           setstudentId(data);
//         }
//       }
//     } catch (e) {
//       //print("Error in getStudentIdapi****::: $e");
//       throw Exception('Failed to fetch student ID*****::::: $e');
//     }
//   }

//   Future<void> setstudentId(int studetid) async {
//     await SharedPrefHelper.setData(SharedPrefranceKeys.studentId, studetid);
//   }

//   // Convenience emitters in case callers want to control state directly
//   // void logInStarted() => emit(LoginLoading());

//   // // void logInSuccess({required String message, required String token}) =>
//   // //     emit(LoginSuccess(loginResponse: message, token: token));

//   // void logInFailure(String message) => emit(LoginFailure(message));
// }
