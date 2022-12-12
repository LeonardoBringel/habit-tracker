import 'package:flutter/material.dart';
import 'package:habit_tracker/models/goal.dart';

import '../components/day_button_widget.dart';

class EditGoalPage extends StatefulWidget {
  const EditGoalPage({super.key});

  @override
  State<EditGoalPage> createState() => _EditGoalPageState();
}

class _EditGoalPageState extends State<EditGoalPage> {
  List<String> selectedDays = [];

  final nameFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

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
            onPressed: () => Navigator.pop(
              context,
              Goal(
                name: nameFieldController.text,
                description: nameFieldController.text,
                days: _getSelectedDays(),
                icon: Icons.auto_awesome,
                completedDates: [],
              ),
            ),
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
            TextFormField(
              controller: nameFieldController,
              style: const TextStyle(fontSize: 18),
              maxLength: 24,
              decoration: InputDecoration(
                hintText: 'My Goal',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(30)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(30)),
                contentPadding: const EdgeInsets.all(25),
              ),
            ),
            TextFormField(
              controller: descriptionFieldController,
              style: const TextStyle(fontSize: 18),
              maxLength: 165,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'A short description of my goal',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(30)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(30)),
                contentPadding: const EdgeInsets.all(25),
              ),
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
