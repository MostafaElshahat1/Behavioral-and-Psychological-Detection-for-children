// feature/image procesing/image_in.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/helper/spacing.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/core/widgets/app_text_button.dart';
import 'package:grade_project/core/widgets/app_text_form_field.dart';
import 'package:grade_project/feature/image%20procesing/imagequbit_cubit.dart';
import 'package:sizer/sizer.dart';

class ImageIn extends StatefulWidget {
  const ImageIn({super.key});

  @override
  State<ImageIn> createState() => _ImageInState();
}

class _ImageInState extends State<ImageIn> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageQubitCubit = context.read<ImagequbitCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Image In ')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFormField(
                validator: (value) {
                  if (controller.text.isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
                hinttext: 'Enter image URL',
                controller: controller,
              ),
              verticalSpace(3),
              SizedBox(
                height: 10.h,
                child: MyTextButton(
                  onpressed: () async {
                    if (!formKey.currentState!.validate()) return;

                    // show loading dialog
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      final resp = await imageQubitCubit.sendImageUrl(
                        controller.text,
                      );

                      // إزالة شاشة التحميل
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }

                      if (resp != null &&
                          resp.isSuccess &&
                          resp.result != null) {
                        if (context.mounted) {
                          context.pushNamed(
                            IRouts.imageOutScreen,
                            arguments: resp.result,
                          );
                        }
                      } else {
                        String msg;
                        if (resp == null) {
                          msg = 'Request failed';
                        } else if (resp.errorMessages != null &&
                            resp.errorMessages!.isNotEmpty) {
                          msg = resp.errorMessages!.join(', ');
                        } else {
                          msg = 'Unknown server response';
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(msg)));
                        }
                      }
                    } catch (e) {
                      // //print("============>>>>>>>>>Caught error in UI: $e");
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  buttonText: "send",
                  textStyle: TextStyle(fontSize: 26.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
