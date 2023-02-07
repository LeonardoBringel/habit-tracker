import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.maxLength,
    required this.hintText,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final int maxLength;
  final int maxLines;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 18),
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorTheme.secondary),
            borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorTheme.primary),
            borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.all(25),
      ),
    );
  }
}
