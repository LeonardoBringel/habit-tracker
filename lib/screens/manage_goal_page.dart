import 'package:flutter/material.dart';

import '../components/custom_text_form_field_widget.dart';
import '../components/day_button_widget.dart';
import '../components/snackbar_message.dart';
import '../models/goal.dart';

class EditGoalPage extends StatefulWidget {
  const EditGoalPage({super.key});

  @override
  State<EditGoalPage> createState() => _EditGoalPageState();
}

class _EditGoalPageState extends State<EditGoalPage> {
  List<String> selectedDays = [];

  final nameFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  List<IconData> icons = const [
    Icons.auto_awesome,
    Icons.cake,
    Icons.school,
    Icons.favorite_rounded,
    Icons.credit_card,
    Icons.rocket_launch_rounded,
    Icons.airplanemode_on_rounded,
  ];

  IconData selectedIcon = Icons.auto_awesome;

  final List<List<DayButtonWidget>> listsOfDayButtons = [
    [
      DayButtonWidget('MON'),
      DayButtonWidget('TUE'),
      DayButtonWidget('WED'),
      DayButtonWidget('THU'),
    ],
    [
      DayButtonWidget('FRI'),
      DayButtonWidget('SAT'),
      DayButtonWidget('SUN'),
    ],
  ];

  List<int> _getSelectedDays() {
    List<int> selectedDays = [];

    final List<DayButtonWidget> combinedListOfDayButtons =
        listsOfDayButtons[0] + listsOfDayButtons[1];

    for (var i = 0; i < 7; i++) {
      if (combinedListOfDayButtons[i].isSelected) {
        selectedDays.add(i + 1);
      }
    }

    return selectedDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Habit Tracker',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameFieldController.text.isEmpty) {
                snackbarMessage(context, 'Every goal must have a name!');
              } else if (_getSelectedDays().isEmpty) {
                snackbarMessage(context, 'At least one day must be selected.');
              } else {
                Navigator.pop(
                  context,
                  Goal(
                    name: nameFieldController.text,
                    description: nameFieldController.text,
                    days: _getSelectedDays(),
                    icon: selectedIcon,
                    completedDates: [],
                  ),
                );
                snackbarMessage(context, 'Goal saved!');
              }
            },
            child: const Text(
              'Done',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
              value: selectedIcon,
              underline: Container(
                height: 2,
                color: Colors.yellow,
              ),
              onChanged: (value) {
                setState(() {
                  selectedIcon = value!;
                });
              },
              items: icons.map<DropdownMenuItem>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Icon(
                    value,
                    color: Colors.yellow,
                  ),
                );
              }).toList(),
            ),
            CustomTextFormFieldWidget(
              controller: nameFieldController,
              maxLength: 24,
              hintText: 'My Goal',
            ),
            CustomTextFormFieldWidget(
              controller: descriptionFieldController,
              maxLength: 165,
              maxLines: 5,
              hintText: 'A short description of my goal',
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listsOfDayButtons[0],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listsOfDayButtons[1],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
