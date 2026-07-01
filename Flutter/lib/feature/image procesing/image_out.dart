// feature/image procesing/image_out.dart
import 'package:flutter/material.dart';
import 'package:grade_project/feature/image%20procesing/image_analysis_model.dart';
import 'package:sizer/sizer.dart';

class ImageOut extends StatelessWidget {
  final ImageAnalyzeResult? result;
  const ImageOut({super.key, this.result});

  String _getDirectImageUrl(String imageUrl) {
    // تحويل Google Drive URL إلى رابط مباشر
    if (imageUrl.contains('drive.google.com')) {
      // استخراج File ID من الرابط
      final regex = RegExp(r'/file/d/([a-zA-Z0-9-_]+)');
      final match = regex.firstMatch(imageUrl);
      if (match != null) {
        final fileId = match.group(1);
        return 'https://drive.google.com/uc?id=$fileId';
      }
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    // Debug: طباعة البيانات
    // if (result != null) {
    //   //print('🖼️ Original URL: ${result!.imageUrl}');
    //   //print('🔗 Direct URL: ${_getDirectImageUrl(result!.imageUrl)}');
    //   //print('📊 Behavior: ${result!.behavior}');
    //   //print('📈 Confidence: ${result!.confidence}');
    // }

    final directImageUrl = result != null
        ? _getDirectImageUrl(result!.imageUrl)
        : null;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(IRouts.welcomeBackStudentScreen),
      //   child: Icon(Icons.keyboard_double_arrow_right_outlined, size: 20.sp),
      // ),
      appBar: AppBar(title: const Text('Image Out'), leading: Container()),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // عرض الصورة
              Container(
                height: 40.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.sp),
                  child: directImageUrl != null && directImageUrl.isNotEmpty
                      ? Image.network(
                          directImageUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // //print('❌ Image load error: $error');
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image,
                                  size: 50.sp,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Failed to load image',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.h,
                                  ),
                                  child: Text(
                                    directImageUrl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 50.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                'No image available',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              SizedBox(height: 4.h),

              // معلومات التحليل
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: Icons.psychology,
                        label: 'Behavior',
                        value: result?.behavior ?? 'N/A',
                      ),
                      Divider(height: 3.h),
                      _buildInfoRow(
                        icon: Icons.bar_chart,
                        label: 'Confidence',
                        value:
                            '${((result?.confidence ?? 0) * 100).toStringAsFixed(1)}%',
                      ),
                      Divider(height: 3.h),
                      _buildInfoRow(
                        icon: Icons.source,
                        label: 'Source',
                        value: result?.source ?? 'N/A',
                      ),
                      if (result?.createdAt != null) ...[
                        Divider(height: 3.h),
                        _buildInfoRow(
                          icon: Icons.access_time,
                          label: 'Created',
                          value: _formatDateTime(result!.createdAt!),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: Colors.blue),
        SizedBox(width: 2.w),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 16.sp)),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${local.day}/${local.month}/${local.year} ${local.hour}:${local.minute.toString().padLeft(2, '0')}';
  }
}
