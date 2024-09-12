import 'package:flutter/material.dart';
import 'package:github_star_app/common/constants/color_constant.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(title, style: AppConstants.appBarTextStyle)),
      backgroundColor: AppConstants.primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
