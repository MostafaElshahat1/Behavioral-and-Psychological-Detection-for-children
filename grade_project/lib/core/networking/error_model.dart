// core/networking/error_model.dart
// ============================================================
// ملف: generic_response_model.dart
// ============================================================

class ErrorModel {
  final int statusCode;
  final bool isSuccess;
  final List<String>? errorMessages;
  final String? result;

  ErrorModel({
    required this.statusCode,
    required this.isSuccess,
    this.errorMessages,
    this.result,
  });

  /// تحويل الـ JSON إلى Object
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json['statusCode'] as int? ?? 0,
      isSuccess: json['isSuccess'] as bool? ?? false,
      errorMessages: (json['errorMessages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      result: json['result'] as String?,
    );
  }

  /// تحويل الـ Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'errorMessages': errorMessages,
      'result': result,
    };
  }

  /// نسخة مع تعديل الحقول
  ErrorModel copyWith({
    int? statusCode,
    bool? isSuccess,
    List<String>? errorMessages,
    String? result,
  }) {
    return ErrorModel(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessages: errorMessages ?? this.errorMessages,
      result: result ?? this.result,
    );
  }

  @override
  String toString() {
    return 'GenericResponse(statusCode: $statusCode, isSuccess: $isSuccess, errorMessages: $errorMessages, result: $result)';
  }
}