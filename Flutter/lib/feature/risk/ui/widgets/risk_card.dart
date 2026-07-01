// feature/risk/ui/widgets/risk_card.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:sizer/sizer.dart';

class RiskCard extends StatelessWidget {
  final List<double> data;
  const RiskCard({super.key, this.data = const [6, 7, 6.5, 5.5, 5]});

  @override
  Widget build(BuildContext context) {
    final cardColor = Colors.white;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(3.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2.w,
            offset: Offset(0, 1.2.w),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 5.h,
                    width: 45.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.2.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC94D),
                      borderRadius: BorderRadius.circular(14.sp),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'MEDIUM ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp,
                            ),
                          ),
                          Text(
                            'RISK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Happy',
                    style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(2),
          SizedBox(
            height: 8.h,
            child: CustomPaint(
              size: Size(double.infinity, 60.h),
              painter: _SparklinePainter(
                data: data,
                lineColor: const Color(0xFFFFC94D),
              ),
            ),
          ),
          verticalSpace(1.6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeekText(day: "Mon"),
              WeekText(day: 'Tue'),
              WeekText(day: 'Wed'),
              WeekText(day: 'Thu'),
              WeekText(day: 'Thu'),
              WeekText(day: 'Fri'),
            ],
          ),
        ],
      ),
    );
  }
}

class WeekText extends StatelessWidget {
  const WeekText({super.key, this.day});
  final String? day;
  @override
  Widget build(BuildContext context) {
    return Text(
      day ?? 'Mon',
      style: TextStyle(color: Colors.black45, fontSize: 15.sp),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  _SparklinePainter({required this.data, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = lineColor.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 15;

    final min = data.reduce((a, b) => a < b ? a : b);
    final max = data.reduce((a, b) => a > b ? a : b);
    final range = (max - min) == 0 ? 1 : (max - min);

    final stepX = size.width / (data.length - 1);

    final points = <Offset>[];
    for (var i = 0; i < data.length; i++) {
      final dx = i * stepX;
      final normalized = (data[i] - min) / range;
      final dy = size.height - (normalized * size.height);
      points.add(Offset(dx, dy));
    }

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, size.height);
    fillPath.lineTo(points.first.dx, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    final outerRadius = size.width * 0.03; // responsive dot
    final innerRadius = outerRadius * 0.5;
    for (final p in points) {
      canvas.drawCircle(p, outerRadius, dotPaint);
      canvas.drawCircle(p, innerRadius, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
