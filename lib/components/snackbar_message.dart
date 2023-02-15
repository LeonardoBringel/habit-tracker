import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/color_theme.dart';

void snackbarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
          color: ColorTheme.primary,
        ),
      ),
      backgroundColor: ColorTheme.faded,
      duration: const Duration(seconds: 3),
    ),
  );
}
