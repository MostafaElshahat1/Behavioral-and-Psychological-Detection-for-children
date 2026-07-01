// feature/report/ui/widgets/report_period_tabs.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReportPeriodTabs extends StatelessWidget {
  const ReportPeriodTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6.h,
            padding: EdgeInsets.all(0.5.sp),
            decoration: BoxDecoration(
              color: const Color.fromARGB(55, 101, 114, 125),
              borderRadius: BorderRadius.circular(26.sp),
            ),
            child: TabBar(
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: const Color(0xFF2E6EB3),
                borderRadius: BorderRadius.circular(26.sp),
              ),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 0.6.w, vertical: 0.2.h),
              labelColor: Colors.white,
              unselectedLabelColor: const Color.fromARGB(255, 44, 51, 62),
              labelStyle: TextStyle(fontSize: 19.sp),
              unselectedLabelStyle: TextStyle(fontSize: 19.sp),
              tabs: [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    child: const Text('Weekly'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    child: const Text('Monthly'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
