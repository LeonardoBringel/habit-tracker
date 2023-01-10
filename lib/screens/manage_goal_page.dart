import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_form_field_widget.dart';
import '../components/day_button_widget.dart';
import '../components/snackbar_message.dart';
import '../models/goal.dart';
import '../repositories/goals_repository.dart';

class ManageGoalPage extends StatefulWidget {
  const ManageGoalPage({super.key});

  @override
  State<ManageGoalPage> createState() => _ManageGoalPageState();
}

class _ManageGoalPageState extends State<ManageGoalPage> {
  late GoalsRepository goalsRepository;

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

  final List<DayButtonWidget> dayButtons = [
    DayButtonWidget('MON'),
    DayButtonWidget('TUE'),
    DayButtonWidget('WED'),
    DayButtonWidget('THU'),
    DayButtonWidget('FRI'),
    DayButtonWidget('SAT'),
    DayButtonWidget('SUN'),
  ];

  List<bool> _getSelectedDays() {
    List<bool> selectedDays = [];

    for (var dayButton in dayButtons) {
      selectedDays.add(dayButton.isSelected);
    }

    return selectedDays;
  }

  @override
  Widget build(BuildContext context) {
    goalsRepository = Provider.of<GoalsRepository>(context);

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
              } else if (!_getSelectedDays().contains(true)) {
                snackbarMessage(context, 'At least one day must be selected.');
              } else {
                goalsRepository.saveGoal(
                  Goal(
                    name: nameFieldController.text,
                    description: nameFieldController.text,
                    days: _getSelectedDays(),
                    iconId: selectedIcon.codePoint,
                  ),
                );
                Navigator.pop(context);
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
                  children: dayButtons.sublist(0, 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dayButtons.sublist(4),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
