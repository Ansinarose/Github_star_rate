// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:github_star_app/common/constants/color_constant.dart';

// A custom app bar widget with a centered title and specific styling.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Title for the app bar, required for displaying text.
  final String title;

  // Constructor to initialize the title.
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Centered title with custom text style.
      title: Center(child: Text(title, style: AppConstants.appBarTextStyle)),
      // Background color from app constants for consistency.
      backgroundColor: AppConstants.primaryColor,
    );
  }

  @override
  // Standard height for app bars.
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
