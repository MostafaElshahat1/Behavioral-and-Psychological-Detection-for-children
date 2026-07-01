// feature/register/data/model/register_response_model.dart
class RegisterResponseModel {
  RegisterResponseModel({
    required this.type,
    required this.title,
    required this.status,
    this.errors,
    required this.traceId,
  });

  final String type;
  final String title;
  final int status;
  final Map<String, List<String>>? errors;
  final String traceId;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final rawErrors = json['errors'];
    Map<String, List<String>>? parsedErrors;

    if (rawErrors is Map) {
      parsedErrors = rawErrors.map(
        (key, value) => MapEntry(
          key.toString(),
          value is List
              ? value.map((item) => item.toString()).toList()
              : <String>[value.toString()],
        ),
      );
    }

    return RegisterResponseModel(
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      status: json['status'] is int
          ? json['status'] as int
          : int.tryParse(json['status']?.toString() ?? '') ?? 0,
      errors: parsedErrors,
      traceId: json['traceId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'status': status,
      'errors': errors,
      'traceId': traceId,
    };
  }

  String get errorMessage {
    if (errors == null || errors!.isEmpty) {
      return title.isNotEmpty ? title : 'Register failed';
    }

    return errors!.entries.map((entry) => entry.value.join(', ')).join(', ');
  }
}
