import 'package:flutter/material.dart';

import 'day_button_widget.dart';

class WeekdayButtonsWidget extends StatelessWidget {
  WeekdayButtonsWidget({super.key});

  final List<DayButtonWidget> _dayButtons = [
    DayButtonWidget('MON'),
    DayButtonWidget('TUE'),
    DayButtonWidget('WED'),
    DayButtonWidget('THU'),
    DayButtonWidget('FRI'),
    DayButtonWidget('SAT'),
    DayButtonWidget('SUN'),
  ];

  void setSelectedDays(List<bool> selectedDays) {
    for (int i = 0; i < 7; i++) {
      _dayButtons[i].isSelected = selectedDays[i];
    }
  }

  List<bool> getSelectedDays() {
    List<bool> selectedDays = [];

    for (var dayButton in _dayButtons) {
      selectedDays.add(dayButton.isSelected);
    }

    return selectedDays;
  }

  bool anySelected() {
    return getSelectedDays().contains(true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _dayButtons.sublist(0, 4),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _dayButtons.sublist(4),
        )
      ],
    );
  }
}
