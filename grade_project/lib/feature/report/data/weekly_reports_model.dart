// feature/report/data/weekly_reports_model.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// feature/report/data/weekly_reports_model.dart
class WeeklyReportsModel {
  final int statusCode;
  final bool isSuccess;
  final List<String>? errorMessages;
  final List<StudentWeeklyReport?> result;

  WeeklyReportsModel({
    required this.statusCode,
    required this.isSuccess,
    this.errorMessages,
    required this.result,
  });

  factory WeeklyReportsModel.fromJson(Map<String, dynamic> json) {
    return WeeklyReportsModel(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      errorMessages: json['errorMessages'] != null
          ? List<String>.from(json['errorMessages'])
          : null,
      //   result: json['result'] != null
      //       ? StudentWeeklyReport.fromJson(json['result'] as Map<String, dynamic>)
      //       : null,
      // );
      result: (json['result'] as List)
          .map((e) => StudentWeeklyReport.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'errorMessages': errorMessages,
      'result': result, // Assuming StudentWeeklyReport has a toJson method
    };
  }
}

class StudentWeeklyReport {
  final int id;
  final int studentId;
  final int weekNumber;
  final int totalImages;
  final int sleepingCount;
  final int lookingBackCount;
  final int handRaisedCount;
  final int writtingCount;
  final int readingCount;
  final int standingCount;
  final int lookingForwardCount;
  final double avgConfidence;
  final String riskLevel;
  final String status;
  final String recomendation;

  StudentWeeklyReport({
    required this.id,
    required this.studentId,
    required this.weekNumber,
    required this.totalImages,
    required this.sleepingCount,
    required this.lookingBackCount,
    required this.handRaisedCount,
    required this.writtingCount,
    required this.readingCount,
    required this.standingCount,
    required this.lookingForwardCount,
    required this.avgConfidence,
    required this.riskLevel,
    required this.status,
    required this.recomendation,
  });

  factory StudentWeeklyReport.fromJson(Map<String, dynamic> json) {
    return StudentWeeklyReport(
      id: json['id'],
      studentId: json['studentId'],
      weekNumber: json['weekNumber'],
      totalImages: json['totalImages'],
      sleepingCount: json['sleepingCount'],
      lookingBackCount: json['lookingBackCount'],
      handRaisedCount: json['handRaisedCount'],
      writtingCount: json['writtingCount'],
      readingCount: json['readingCount'],
      standingCount: json['standingCount'],
      lookingForwardCount: json['lookingForwardCount'],
      avgConfidence: (json['avgConfidence'] as num).toDouble(),
      riskLevel: json['riskLevel'],
      status: json['status'],
      recomendation: json['recomendation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'weekNumber': weekNumber,
      'totalImages': totalImages,
      'sleepingCount': sleepingCount,
      'lookingBackCount': lookingBackCount,
      'handRaisedCount': handRaisedCount,
      'writtingCount': writtingCount,
      'readingCount': readingCount,
      'standingCount': standingCount,
      'lookingForwardCount': lookingForwardCount,
      'avgConfidence': avgConfidence,
      'riskLevel': riskLevel,
      'status': status,
      'recomendation': recomendation,
    };
  }
}

class StudentWeeklyReportmodelWithList {
  final StudentWeeklyReport? result;
  List<StudentWeeklyReport> resultList;
  StudentWeeklyReportmodelWithList({this.result, required this.resultList});
}
