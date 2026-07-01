// feature/report/ui/widgets/report_alert_item.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReportAlertItem extends StatelessWidget {
  const ReportAlertItem({
    super.key,
    required this.icon,
    required this.background,
    required this.title,
  });

  final IconData icon;
  final Color background;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(color: background, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.orange, size: 6.w),
            ),
            SizedBox(width: 3.w),
            Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            Icon(Icons.chevron_right, color: Colors.black26, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
