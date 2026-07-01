// feature/quistions/logic/questions_cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/constance_helper.dart';
import 'package:grade_project/core/helper/shared_prefrance_helper.dart';
import 'package:grade_project/core/networking/error_model.dart';
import 'package:grade_project/feature/quistions/data/model/questions_test_model.dart';
import 'package:grade_project/feature/quistions/data/model/qustion_model.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit({Dio? dio}) : _dio = dio ?? Dio(), super(QuestionsInitial());

  final Dio _dio;
  final List<QuestionAnswerModel> _answers = [];

  // Takes a test id and returns the parsed model from API response.
  Future<QuestionsTestResponse?> getQuestionsById(int testId) async {
    emit(QuestionsLoading());
    testId = 10;
    try {
      final token = await getToken();
      final url = '$baseUrl/quizzes/$testId';

      //print('=== Questions API Call ===');
      //print('URL: $url');
      //print('Token: ${token.isEmpty ? "No token" : "Token present"}');

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
          receiveTimeout: const Duration(seconds: 25),
          sendTimeout: const Duration(seconds: 20),
        ),
      );

      //print('Status Code: ${response.statusCode}');
      //print('Response Data: ${response.data}');

      final raw = response.data;
      if (raw is! Map<String, dynamic>) {
        const message = 'Unexpected response format';
        //print('Error: $message');
        emit(QuestionsFailure(ErrorModel(
          statusCode: response.statusCode ?? 0,
          isSuccess: false,
          errorMessages: [message],
        )));
        return null;
      }

      final model = QuestionsTestResponse.fromJson(raw);
      //print(
      //   'Parsed Model - Success: ${model.isSuccess}, Result: ${model.result != null}',
      // );

      if (model.isSuccess && model.result != null) {
        //print(
        //   'Questions loaded successfully: ${model.result!.questions.length} questions',
        // );
        emit(QuestionsSuccess(model));
      } else {
        final errors = model.errorMessages;
        final message = (errors != null && errors.isNotEmpty)
            ? errors.join(', ')
            : 'Failed to load questions';
        //print('API returned failure: $message');
        emit(QuestionsFailure(ErrorModel(
          statusCode: response.statusCode ?? 0,
          isSuccess: false,
          errorMessages: [message],
        )));
      }

      return model;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;
      final message =
          'Dio error: ${e.message}${status != null ? ' ($status)' : ''}${data != null ? ' - $data' : ''}';
      //print('DioException: $message');
      //print('Full error: $e');
      emit(QuestionsFailure(ErrorModel(
        statusCode: 500,
        isSuccess: false,
        errorMessages: [message],
      )));
      return null;
    } catch (e) {
      final message = e.toString();
      //print('Unexpected error: $message');
      emit(QuestionsFailure(ErrorModel(
        statusCode: 500,
        isSuccess: false,
        errorMessages: [message],
      )));
      return null;
    }
  }

  Future<String> getToken() async {
    return SharedPrefHelper.getSecuredString(SharedPrefranceKeys.userToken);
  }

  Future<int> getUserId() async {
    final userId = await SharedPrefHelper.getSecuredString(
      SharedPrefranceKeys.userId,
    );
    return int.tryParse(userId) ?? 0;
  }

  List<QuestionAnswerModel> get answers => List.unmodifiable(_answers);

  void addOrUpdateAnswer({required int questionId, required String value}) {
    final index = _answers.indexWhere((item) => item.questionId == questionId);
    final answer = QuestionAnswerModel(questionId: questionId, value: value);

    if (index == -1) {
      _answers.add(answer);
    } else {
      _answers[index] = answer;
    }
  }

  void removeAnswer(int questionId) {
    _answers.removeWhere((item) => item.questionId == questionId);
  }

  void clearAnswers() {
    _answers.clear();
  }

  QuestionModel buildSubmissionPayload({required int studentId}) {
    return QuestionModel(
      studentId: studentId,
      answers: List<QuestionAnswerModel>.unmodifiable(_answers),
    );
  }

  Future<bool> submitQuiz({required int quizId, int? studentId}) async {
    emit(QuestionsSubmitLoading());
    int quizId = 10;
    try {
      final token = await getToken();
      final resolvedStudentId = await getUserId();
      final url = '$baseUrl/quizzes/$quizId/submit';
      final payload = buildSubmissionPayload(studentId: resolvedStudentId);

      //print('=== Questions Submit API Call ===');
      //print('URL: $url');
      //print('Payload: ${payload.toJson()}');

      final response = await _dio.post(
        url,
        data: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
          receiveTimeout: const Duration(seconds: 25),
          sendTimeout: const Duration(seconds: 20),
        ),
      );

      final statusCode = response.statusCode ?? 0;
      final isSuccess = statusCode >= 200 && statusCode < 300;

      if (isSuccess) {
        emit(QuestionsSubmitSuccess('Quiz submitted successfully'));
        return true;
      }

      // final message = 'Failed to submit quiz';
      emit(QuestionsSubmitFailure(ErrorModel(
        statusCode: statusCode,
        isSuccess: false,
        errorMessages: ['Failed to submit quiz'],
      )));
      return false;
    } on DioException catch (e) {
      // final status = e.response?.statusCode;
      // final data = e.response?.data;
      // final message =
      //     'Dio error: ${e.message}${status != null ? ' ($status)' : ''}${data != null ? ' - $data' : ''}';
      
      
      emit(QuestionsSubmitFailure(ErrorModel.fromJson( e.response?.data ?? {})));
      return false;
    } catch (e) {
      //print('Unexpected error: $e');
      final message = e.toString();
      emit(QuestionsSubmitFailure(ErrorModel(
        statusCode: 500,
        isSuccess: false,
        errorMessages: [message],
      )));
      return false;
    }
  }

  /// Get total count of options from the API response
  int getOptionsCount() {
    if (state is QuestionsSuccess) {
      final successState = state as QuestionsSuccess;
      return successState.model.result?.totalOptionsCount ?? 0;
    }
    return 0;
  }
}
