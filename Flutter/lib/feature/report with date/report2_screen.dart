// feature/report with date/report2_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/feature/report%20with%20date/widgets/report2_alert_card.dart';
import 'package:grade_project/feature/report%20with%20date/widgets/report2_header_section.dart';
import 'package:grade_project/feature/report/logic/report_cubit.dart';
import 'package:sizer/sizer.dart';

class Report2Screen extends StatefulWidget {
  const Report2Screen({super.key});

  @override
  State<Report2Screen> createState() => _Report2ScreenState();
}

class _Report2ScreenState extends State<Report2Screen> {
  @override
  initState() {
    super.initState();
    context.read<ReportCubit>().getReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(IRouts.imageReportsScreen),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.8.h),
              const Report2HeaderSection(),
              SizedBox(height: 4.h),
              BlocBuilder<ReportCubit, ReportState>(
                builder: (context, state) {
                  if (state is ReportFailure) {
                    return Text(
                      state.errorModel.errorMessages?.join(",") ??
                          'Unknown Error',
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    );
                  }
                  if (state is ReportSucess) {
                    final alerts = state.reportItems;
                    //print("report lenth :::::${alerts?.length}");
                    return Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: alerts!.length,
                        separatorBuilder: (_, _) => SizedBox(height: 2.h),
                        itemBuilder: (context, index) =>
                            Report2AlertCard(report: alerts[index]!),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator.adaptive());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
