// feature/image procesing/image_analysis_model.dart
// Models for the image analyze API response

class ImageAnalyzeResponse {
  final int statusCode;
  final bool isSuccess;
  final List<String>? errorMessages;
  final ImageAnalyzeResult? result;

  ImageAnalyzeResponse({
    required this.statusCode,
    required this.isSuccess,
    this.errorMessages,
    this.result,
  });

  factory ImageAnalyzeResponse.fromJson(Map<String, dynamic> json) {
    List<String>? errors;
    final rawErrors = json['errorMessages'];
    if (rawErrors is List) {
      errors = rawErrors
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
      if (errors.isEmpty) errors = null;
    }

    return ImageAnalyzeResponse(
      statusCode: json['statusCode'] as int? ?? 0,
      isSuccess: json['isSuccess'] as bool? ?? false,
      errorMessages: errors,
      result: json['result'] == null
          ? null
          : ImageAnalyzeResult.fromJson(
              Map<String, dynamic>.from(json['result'] as Map),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'isSuccess': isSuccess,
    'errorMessages': errorMessages,
    'result': result?.toJson(),
  };

  @override
  String toString() {
    return 'ImageAnalyzeResponse(statusCode: $statusCode, isSuccess: $isSuccess, errorMessages: $errorMessages, result: ${result?.toJson()})';
  }
}

class ImageAnalyzeResult {
  final int id;
  final String imageUrl;
  final String behavior;
  final int confidence;
  final String source;
  final DateTime? createdAt;

  ImageAnalyzeResult({
    required this.id,
    required this.imageUrl,
    required this.behavior,
    required this.confidence,
    required this.source,
    this.createdAt,
  });

  factory ImageAnalyzeResult.fromJson(Map<String, dynamic> json) {
    return ImageAnalyzeResult(
      id: json['id'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
      behavior: json['behavior'] as String? ?? '',
      confidence: json['confidence'] ?? 0,
      source: json['source'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'behavior': behavior,
    'confidence': confidence,
    'source': source,
    'createdAt': createdAt?.toIso8601String(),
  };
}
