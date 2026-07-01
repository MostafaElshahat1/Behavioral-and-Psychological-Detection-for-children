// feature/image procesing/imagequbit_cubit.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/constance_helper.dart';
import 'package:grade_project/core/helper/shared_prefrance_helper.dart';
import 'package:grade_project/feature/image%20procesing/image_analysis_model.dart';
import 'package:grade_project/feature/image%20procesing/imagequbit_state.dart';

class ImagequbitCubit extends Cubit<ImagequbitState> {
  ImagequbitCubit() : super(ImagequbitInitial());

  /// Posts [url] to the analyze endpoint, emits states, and returns the parsed model.
  /// Returns `null` if the request failed.
  Future<ImageAnalyzeResponse?> sendImageUrl(String url) async {
    emit(ImagequbitLoading());

    try {
      final token = await getToken();

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      };
      var data = json.encode({"url": url});

      var dio = Dio();
      final response = await dio.request(
        '$baseUrl/images/analyze',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      final status = response.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        final data = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : Map<String, dynamic>.from(response.data as Map);

        final model = ImageAnalyzeResponse.fromJson(data);

        if (model.isSuccess) {
          emit(ImagequbitSuccess());
        } else {
          final errors = model.errorMessages;
          final msg = (errors != null && errors.isNotEmpty)
              ? errors.join(', ')
              : 'Analysis failed';
          emit(ImagequbitError(msg));
        }

        return model;
      } else {
        final msg = 'Server error: $status - ${response.data}';
        emit(ImagequbitError(msg));
        return ImageAnalyzeResponse(
          statusCode: status,
          isSuccess: false,
          errorMessages: [msg],
          result: null,
        );
      }
    } catch (e) {
      // handle Dio errors with response body (like 400 validation)
      if (e is DioException && e.response != null) {
        final r = e.response!;
        final status = r.statusCode ?? 0;

        // طباعة تفاصيل الخطأ من السيرفر

        // try to extract server validation messages
        try {
          final data = r.data;
          List<String>? errors;
          if (data is Map<String, dynamic>) {
            // server may return { errors: { url: [..] } }
            if (data['errorMessages'] is List) {
              errors = List<String>.from(data['errorMessages']);
            } else if (data['errors'] is Map) {
              final m = Map<String, dynamic>.from(data['errors'] as Map);
              final list = <String>[];
              m.forEach((k, v) {
                if (v is List) {
                  for (var item in v) {
                    list.add(item?.toString() ?? '');
                  }
                } else {
                  list.add(v?.toString() ?? '');
                }
              });
              if (list.isNotEmpty) errors = list;
            }

            final model = ImageAnalyzeResponse(
              statusCode: status,
              isSuccess: false,
              errorMessages: errors,
              result: null,
            );
            final msg = errors != null
                ? errors.join(', ')
                : 'Server error: $status';
            // ignore: avoid_//print
            //print('analyzeImage error response: $data');
            emit(ImagequbitError(msg));
            return model;
          }
        } catch (_) {
          // fallthrough to generic handling
        }
        final msg = 'Dio error: ${e.message} - ${r.statusCode} ${r.data}';
        // ignore: avoid_//print
        //print('analyzeImage error: $msg');
        emit(ImagequbitError(msg));
        return ImageAnalyzeResponse(
          statusCode: r.statusCode ?? 0,
          isSuccess: false,
          errorMessages: [msg],
          result: null,
        );
      }

      final msg = e is DioException ? 'Dio error: ${e.message}' : e.toString();
      // ignore: avoid_//print
      //print('analyzeImage error: $msg');
      emit(ImagequbitError(msg));
      return ImageAnalyzeResponse(
        statusCode: 0,
        isSuccess: false,
        errorMessages: [msg],
        result: null,
      );
    }
  }

  Future<String> getToken() async {
    return await SharedPrefHelper.getSecuredString(
      SharedPrefranceKeys.userToken,
    );
  }
}

// Future<ImageAnalyzeResponse> analyzeImage(String imageUrl) async {
//   final dio = Dio(
//     BaseOptions(
//       baseUrl: 'http://pixel-vision.runasp.net',
//       connectTimeout: const Duration(seconds: 15),
//       receiveTimeout: const Duration(seconds: 20),
//       headers: {'Content-Type': 'application/json'},
//     ),
//   );

//   final resp = await dio.get(
//     '/api/images/analyze/',
//     queryParameters: {'imageUrl': imageUrl},
//   );
//   final status = resp.statusCode ?? 0;
//   if (status >= 200 && status < 300) {
//     final data = resp.data;
//     if (data is Map<String, dynamic>) {
//       return ImageAnalyzeResponse.fromJson(data);
//     }
//     // Dio may decode JSON to a Map<dynamic, dynamic>
//     return ImageAnalyzeResponse.fromJson(
//       Map<String, dynamic>.from(data as Map),
//     );
//   }
//   throw Exception('Server error: $status');
// }
