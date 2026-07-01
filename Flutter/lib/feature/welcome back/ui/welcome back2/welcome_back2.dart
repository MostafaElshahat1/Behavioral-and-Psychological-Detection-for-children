// feature/welcome back/ui/welcome back2/welcome_back2.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:sizer/sizer.dart';

class WelcomeBack2Page extends StatefulWidget {
  const WelcomeBack2Page({super.key});

  @override
  State<WelcomeBack2Page> createState() => _WelcomeBack2PageState();
}

class _WelcomeBack2PageState extends State<WelcomeBack2Page> {
  int _selected = 0;

  final List<Map<String, dynamic>> _opts = [
    {'label': 'Rarely', 'icon': Icons.sentiment_very_satisfied},
    {'label': 'Sometimes', 'icon': Icons.sentiment_satisfied},
    {'label': 'Often', 'icon': Icons.sentiment_dissatisfied},
  ];

  String get _large => _opts[_selected]['label'] as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(IRouts.welcome3Screen),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back, size: 20.sp, color: Colors.black87),
                    Icon(
                      Icons.notifications,
                      size: 24.sp,
                      color: Colors.black54,
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // progress
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         height: 1.1.h,
                //         decoration: BoxDecoration(
                //           color: Colors.grey.shade200,
                //           borderRadius: BorderRadius.circular(12.sp),
                //         ),
                //         child: Align(
                //           alignment: Alignment.centerLeft,
                //           child: FractionallySizedBox(
                //             widthFactor: progress,
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 color: Color(0xFF4A90E2),
                //                 borderRadius: BorderRadius.circular(12.sp),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 3.w),
                //     Text(
                //       '$_step of $_total',
                //       style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                //     ),
                //   ],
                // ),
                SizedBox(height: 4.h),

                Text(
                  'How often do you feel tired or fatigued?',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF11223A),
                  ),
                ),

                SizedBox(height: 3.h),

                // small choices
                Row(
                  children: List.generate(_opts.length, (i) {
                    final opt = _opts[i];
                    final sel = _selected == i;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selected = i),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16.sp),
                            border: Border.all(
                              color: sel
                                  ? Color(0xFF2E6EB3)
                                  : Colors.transparent,
                              width: sel ? 0.6.w : 0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 14.w,
                                height: 14.w,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    opt['icon'] as IconData,
                                    size: 28.sp,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                opt['label'] as String,
                                style: TextStyle(
                                  fontSize: sel ? 18.sp : 16.sp,
                                  fontWeight: sel
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 3.h),

                // large card
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 241, 241),
                      borderRadius: BorderRadius.circular(16.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14.w,
                          height: 14.w,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.sentiment_dissatisfied,
                              size: 28.sp,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            _large,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF11223A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 2.5.h),

                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.sp),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 1.h,
                      ),
                    ),
                    child: Text(
                      'Skip Question',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    ),
                  ),
                ),

                //   Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.sp),
                      ),
                      elevation: 8,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.black26,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(IRouts.welcome3Screen);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF4A90E2), Color(0xFF2E6EB3)],
                          ),
                          borderRadius: BorderRadius.circular(28.sp),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 8.h,
                          child: Text(
                            'Back to Home',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
