// feature/login/data/model/get_student_id_model.dart
// ============================================================
// ملف: parent_student_response.dart
// ============================================================

class ParentStudentResult {
  final int parentId;
  final int studentId;

  ParentStudentResult({
    required this.parentId,
    required this.studentId,
  });

  factory ParentStudentResult.fromJson(Map<String, dynamic> json) {
    return ParentStudentResult(
      parentId: json['parentId'] as int,
      studentId: json['studentId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'studentId': studentId,
    };
  }

  ParentStudentResult copyWith({
    int? parentId,
    int? studentId,
  }) {
    return ParentStudentResult(
      parentId: parentId ?? this.parentId,
      studentId: studentId ?? this.studentId,
    );
  }

  @override
  String toString() => 'ParentStudentResult(parentId: $parentId, studentId: $studentId)';
}

// ============================================================

class ParentStudentResponse {
  final int statusCode;
  final bool isSuccess;
  final List<String>? errorMessages;
  final ParentStudentResult? result;

  ParentStudentResponse({
    required this.statusCode,
    required this.isSuccess,
    this.errorMessages,
    this.result,
  });

  /// تحويل الـ JSON إلى Object
  factory ParentStudentResponse.fromJson(Map<String, dynamic> json) {
    return ParentStudentResponse(
      statusCode: json['statusCode'] as int,
      isSuccess: json['isSuccess'] as bool,
      errorMessages: (json['errorMessages'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      result: json['result'] != null
          ? ParentStudentResult.fromJson(json['result'])
          : null,
    );
  }

  /// تحويل الـ Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'errorMessages': errorMessages,
      'result': result?.toJson(),
    };
  }

  /// نسخة مع تعديل الحقول
  ParentStudentResponse copyWith({
    int? statusCode,
    bool? isSuccess,
    List<String>? errorMessages,
    ParentStudentResult? result,
  }) {
    return ParentStudentResponse(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessages: errorMessages ?? this.errorMessages,
      result: result ?? this.result,
    );
  }

  @override
  String toString() {
    return 'ParentStudentResponse(statusCode: $statusCode, isSuccess: $isSuccess, errorMessages: $errorMessages, result: $result)';
  }

  // operator [](String other) {}
}