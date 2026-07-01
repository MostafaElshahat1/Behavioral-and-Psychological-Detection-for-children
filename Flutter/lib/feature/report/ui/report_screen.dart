// feature/report/ui/report_screen.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/feature/report/ui/widgets/report_alert_item.dart';
import 'package:grade_project/feature/report/ui/widgets/report_date_download.dart';
import 'package:grade_project/feature/report/ui/widgets/report_grouped_chart.dart';
import 'package:grade_project/feature/report/ui/widgets/report_overview_header.dart';
import 'package:grade_project/feature/report/ui/widgets/report_period_tabs.dart';
import 'package:sizer/sizer.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(IRouts.riskScreen),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 3.h),
                const ReportPeriodTabs(),
                SizedBox(height: 2.h),
                const DateDownloadPdf(),
                verticalSpace(2),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.w),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const EmilysColumn(),
                      const ReportGroupedBarChart(),
                      verticalSpace(3),
                      Text(
                        'Recent Allerts',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Column(
                        children: [
                          ReportAlertItem(
                            icon: Icons.priority_high,
                            background: Colors.orange.shade100,
                            title: 'Repeated aggression',
                          ),
                          SizedBox(height: 1.h),
                          ReportAlertItem(
                            icon: Icons.mood_bad,
                            background: Colors.green.shade100,
                            title: 'Low engagement in class',
                          ),
                          SizedBox(height: 1.h),
                          ReportAlertItem(
                            icon: Icons.sentiment_dissatisfied,
                            background: Colors.yellow.shade100,
                            title: 'Smokie withdrawal',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
