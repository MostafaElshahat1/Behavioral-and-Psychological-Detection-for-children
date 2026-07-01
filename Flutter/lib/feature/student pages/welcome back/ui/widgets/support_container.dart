// feature/parent pages/welcome back/ui/widgets/support_container.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupportContainer extends StatelessWidget {
  const SupportContainer({
    super.key,
    required this.onSupportTap,
    required this.onContactTap,
  });

  final VoidCallback? onSupportTap;
  final VoidCallback? onContactTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFF1),
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            onTap: onSupportTap,
            title: Text(
              'Support',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF23252B),
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: const Color(0xFF73777E),
              size: 21.sp,
            ),
          ),
          Divider(height: 1, color: Colors.black.withOpacity(0.20)),
          InkWell(
            onTap: onContactTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 18.sp,
                    color: const Color(0xFF2F6A9B),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'contact us',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF23252B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
