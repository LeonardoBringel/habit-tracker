import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

void createSnackbarMessage(BuildContext context, String message) {
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
