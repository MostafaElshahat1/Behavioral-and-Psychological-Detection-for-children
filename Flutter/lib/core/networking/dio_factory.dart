// core/networking/dio_factory.dart
import 'package:dio/dio.dart';
import 'package:grade_project/core/helper/constance_helper.dart';
import 'package:grade_project/core/helper/shared_prefrance_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? dio;
  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 90);
    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      // adabtHeader();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void adabtHeader() async {
    dio?.options.headers = {
      "Accept": "application/json",
      "Authorization":
          "Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefranceKeys.userToken)}",
    };
  }

  static void setTokenAfterLogin(String token) async {
    dio?.options.headers = {"Authorization": "Bearer $token"};
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
