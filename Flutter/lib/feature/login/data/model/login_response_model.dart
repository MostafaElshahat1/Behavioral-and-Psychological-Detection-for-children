// feature/login/data/model/login_response_model.dart
class LoginResponse {
  LoginResponse({
    required this.statusCode,
    required this.isSuccess,
    this.errorMessages,
    this.result,
  });

  final int statusCode;
  final bool isSuccess;
  final List<String>? errorMessages;
  final LoginResult? result;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '') ?? 0,
      isSuccess: json['isSuccess'] == true,
      errorMessages: (json['errorMessages'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      result: json['result'] is Map<String, dynamic>
          ? LoginResult.fromJson(json['result'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'isSuccess': isSuccess,
    'errorMessages': errorMessages,
    'result': result?.toJson(),
  };
}

class LoginResult {
  LoginResult({
    required this.message,
    required this.token,
    required this.role,
    required this.userId,
  });

  final String message;
  final String token;
  final String role;
  final int userId;

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      message: json['message']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      userId: json['userId'] is int
          ? json['userId'] as int
          : int.tryParse(json['userId']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'token': token,
    'role': role,
    'userId': userId,
  };
}
