// core/widgets/core_app_bar.dart
import 'package:flutter/material.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/theming/text_style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.appBartext});
  final String? appBartext;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      centerTitle: true,
      title: Text(
        appBartext ?? "AppBar",
        style: MyTextStyles.font18DarkBlueSemiBold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
