// feature/report with date/widgets/report2_alert_card.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// feature/report with date/widgets/report2_alert_card.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/report%20with%20date/widgets/report2_models.dart';
import 'package:grade_project/feature/report/data/weekly_reports_model.dart';

class Report2AlertCard extends StatelessWidget {
  const Report2AlertCard({super.key, required this.report});

  // final ReportAlertItem item;
  final StudentWeeklyReport report;

  @override
  Widget build(BuildContext context) {
    List<AlertLevel> alerts = [AlertLevel.warning, AlertLevel.neutral];
    AlertLevel level = Random().nextInt(alerts.length) < alerts.length
        ? alerts[Random().nextInt(alerts.length)]
        : AlertLevel.neutral;
    final (Color foreground, Color background) = _paletteFor(level);

    return InkWell(
      onTap: () {
        context.pushNamed(IRouts.imageReportsScreen, arguments: ReportCardModel(report: report, color: background));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.55.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3F7),
          borderRadius: BorderRadius.circular(4.3.w),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.priority_high_rounded,
                size: 14.2.sp,
                color: foreground,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                report.riskLevel,
                style: TextStyle(
                  color: const Color(0xFF181818),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF787878),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  (Color, Color) _paletteFor(AlertLevel level) {
    switch (level) {
      case AlertLevel.warning:
        return (const Color(0xFFDE8C10), const Color(0xFFFFE8C2));
      case AlertLevel.neutral:
        return (const Color(0xFF7B7B7B), const Color(0xFFE4E4E4));
    }
  }
}

class ReportCardModel {
  final StudentWeeklyReport report;
  final Color? color;
  ReportCardModel({
    required this.report,
    this.color,
  });
}
