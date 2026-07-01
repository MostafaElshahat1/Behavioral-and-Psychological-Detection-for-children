// feature/quistions/data/model/questions_test_model.dart
class QuestionsTestResponse {
  final int statusCode;
  final bool isSuccess;
  final List<String>? errorMessages;
  final QuestionsTestData? result;

  const QuestionsTestResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errorMessages,
    required this.result,
  });

  factory QuestionsTestResponse.fromJson(Map<String, dynamic> json) {
    return QuestionsTestResponse(
      statusCode: _asInt(json['statusCode']),
      isSuccess: json['isSuccess'] == true,
      errorMessages: _asStringList(json['errorMessages']),
      result: json['result'] is Map<String, dynamic>
          ? QuestionsTestData.fromJson(json['result'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'errorMessages': errorMessages,
      'result': result?.toJson(),
    };
  }
}

class QuestionsTestData {
  final int id;
  final String title;
  final String description;
  final List<QuestionItem> questions;

  const QuestionsTestData({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory QuestionsTestData.fromJson(Map<String, dynamic> json) {
    final rawQuestions = json['questions'];
    return QuestionsTestData(
      id: _asInt(json['id']),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      questions: rawQuestions is List
          ? rawQuestions
                .whereType<Map<String, dynamic>>()
                .map(QuestionItem.fromJson)
                .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }

  /// Get total count of options across all questions
  int get totalOptionsCount {
    int total = 0;
    for (final question in questions) {
      total += question.optionsCount;
    }
    return total;
  }
}

class QuestionItem {
  final int id;
  final String text;
  final int order;
  final List<QuestionOption> options;

  const QuestionItem({
    required this.id,
    required this.text,
    required this.order,
    required this.options,
  });

  factory QuestionItem.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'];
    return QuestionItem(
      id: _asInt(json['id']),
      text: (json['text'] ?? '').toString(),
      order: _asInt(json['order']),
      options: rawOptions is List
          ? rawOptions
                .whereType<Map<String, dynamic>>()
                .map(QuestionOption.fromJson)
                .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'order': order,
      'options': options.map((e) => e.toJson()).toList(),
    };
  }

  /// Get count of options for this question
  int get optionsCount => options.length;
}

class QuestionOption {
  final int id;
  final String text;
  final String value;

  const QuestionOption({
    required this.id,
    required this.text,
    required this.value,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> json) {
    return QuestionOption(
      id: _asInt(json['id']),
      text: (json['text'] ?? '').toString(),
      value: (json['value'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'value': value};
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

List<String>? _asStringList(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  return null;
}
