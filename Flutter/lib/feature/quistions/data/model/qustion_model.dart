// feature/quistions/data/model/qustion_model.dart
class QuestionModel {
  final int studentId;
  final List<QuestionAnswerModel> answers;

  const QuestionModel({
    required this.studentId,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final rawAnswers = json['answers'];
    return QuestionModel(
      studentId: _asInt(json['studentId']),
      answers: rawAnswers is List
          ? rawAnswers
              .whereType<Map<String, dynamic>>()
              .map(QuestionAnswerModel.fromJson)
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'answers': answers.map((e) => e.toJson()).toList(),
    };
  }
}

class QuestionAnswerModel {
  final int questionId;
  final String value;

  const QuestionAnswerModel({
    required this.questionId,
    required this.value,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionAnswerModel(
      questionId: _asInt(json['questionId']),
      value: (json['value'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'value': value,
    };
  }
}

int _asInt(dynamic value) {
  if (value is int) {
    return value;
  }
  if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}
