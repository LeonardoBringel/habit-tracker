import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

// ignore: must_be_immutable
class DayButtonWidget extends StatefulWidget {
  DayButtonWidget(this.day, {super.key});

  final String day;
  bool isSelected = false;

  @override
  State<DayButtonWidget> createState() => _DayButtonWidgetState();
}

class _DayButtonWidgetState extends State<DayButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            widget.isSelected ? ColorTheme.primary : ColorTheme.faded,
        foregroundColor:
            widget.isSelected ? ColorTheme.faded : ColorTheme.primary,
      ),
      child: Text(widget.day),
    );
  }
}
