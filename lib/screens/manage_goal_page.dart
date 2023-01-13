import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_form_field_widget.dart';
import '../components/icons_dropdown_widget.dart';
import '../components/snackbar_message.dart';
import '../components/weekday_buttons_widget.dart';
import '../models/goal.dart';
import '../repositories/goals_repository.dart';

class ManageGoalPage extends StatefulWidget {
  const ManageGoalPage({super.key, this.goal});

  final Goal? goal;

  @override
  State<ManageGoalPage> createState() => _ManageGoalPageState();
}

class _ManageGoalPageState extends State<ManageGoalPage> {
  late GoalsRepository goalsRepository;

  final nameFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  final iconsDropdownWidget = IconsDropdownWidget();
  final weekdayButtonsWidget = WeekdayButtonsWidget();

  @override
  void initState() {
    if (widget.goal != null) {
      nameFieldController.text = widget.goal!.name;
      descriptionFieldController.text = widget.goal!.description;
      iconsDropdownWidget.selectedIcon =
          IconData(widget.goal!.iconId, fontFamily: 'MaterialIcons');

      weekdayButtonsWidget.setSelectedDays(widget.goal!.days);
    }

    super.initState();
  }

  void _saveGoal() {
    if (nameFieldController.text.isEmpty) {
      snackbarMessage(context, 'Every goal must have a name!');
    } else if (!weekdayButtonsWidget.anySelected()) {
      snackbarMessage(context, 'At least one day must be selected.');
    } else {
      goalsRepository.saveGoal(
        Goal(
          id: widget.goal != null ? widget.goal!.id : -1,
          name: nameFieldController.text,
          description: descriptionFieldController.text,
          days: weekdayButtonsWidget.getSelectedDays(),
          iconId: iconsDropdownWidget.selectedIcon.codePoint,
        ),
      );
      Navigator.pop(context);
      snackbarMessage(context, 'Goal saved!');
    }
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
            onPressed: _saveGoal,
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
            iconsDropdownWidget,
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
            weekdayButtonsWidget,
          ],
        ),
      ),
    );
  }
}
