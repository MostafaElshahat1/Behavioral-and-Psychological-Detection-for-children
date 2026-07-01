// feature/report/ui/widgets/report_grouped_chart.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class ReportGroupedBarChart extends StatelessWidget {
  const ReportGroupedBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final double chartHeight = 16.h;
    return SizedBox(
      height: chartHeight + 4.2.h,
      child: Stack(
        children: [
          NumbersColumns(chartHeight: chartHeight),
          Positioned(
            bottom: 1.h,
            top: 2.h,
            left: 0,
            right: 0,
            child: AggressionRow(chartHeight: chartHeight),
          ),
        ],
      ),
    );
  }
}

class NumbersColumns extends StatelessWidget {
  const NumbersColumns({super.key, required this.chartHeight});

  final double chartHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: chartHeight - 2.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalSpace(2),
              Text('36', style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
              Text('24', style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
              Text('12', style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
              Text('0', style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
            ],
          ),
        ),
        horezontalSpace(4),
        Expanded(
          child: SizedBox(
            height: chartHeight - 4.h,
            child: Column(
              children: List.generate(
                4,
                (_) => Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AggressionRow extends StatelessWidget {
  const AggressionRow({super.key, required this.chartHeight});

  final double chartHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Spacer(),
        _ChartGroup(
          bars: [chartHeight * 0.5, chartHeight * 0.35, chartHeight * 0.6],
          label: 'Aggression\nissue',
        ),
        horezontalSpace(3),
        _ChartGroup(
          bars: [chartHeight * 0.2, chartHeight * 0.3, chartHeight * 0.6],
          label: 'Engagement\nin class',
        ),
        const Spacer(),
      ],
    );
  }
}

class _ChartGroup extends StatelessWidget {
  const _ChartGroup({required this.bars, required this.label});

  final List<double> bars;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _bar(bars[0], Colors.lightBlue.shade100),
            SizedBox(width: 1.w),
            _bar(bars[1], Colors.lightBlue.shade200),
            SizedBox(width: 1.w),
            _bar(bars[2], Colors.orange.shade300),
          ],
        ),
        SizedBox(height: 1.h),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
      ],
    );
  }

  Widget _bar(double height, Color color) {
    return Container(
      width: 7.w,
      height: height,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.sp)),
    );
  }
}
