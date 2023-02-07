import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_form_field_widget.dart';
import '../components/icons_carousel_widget.dart';
import '../components/snackbar_message.dart';
import '../components/weekday_buttons_widget.dart';
import '../models/goal.dart';
import '../repositories/goals_repository.dart';
import '../theme/color_theme.dart';

class ManageGoalPage extends StatelessWidget {
  ManageGoalPage({super.key, this.goal});

  final Goal? goal;

  final nameFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  final iconsCarouselWidget = IconsCarouselWidget();
  final weekdayButtonsWidget = WeekdayButtonsWidget();

  void _saveGoal(BuildContext context, var goalsRepository) {
    if (nameFieldController.text.isEmpty) {
      snackbarMessage(context, 'Every goal must have a name!');
    } else if (!weekdayButtonsWidget.anySelected()) {
      snackbarMessage(context, 'At least one day must be selected.');
    } else {
      goalsRepository.saveGoal(
        Goal(
          id: goal != null ? goal!.id : -1,
          name: nameFieldController.text,
          description: descriptionFieldController.text,
          days: weekdayButtonsWidget.getSelectedDays(),
          iconId: iconsCarouselWidget.selectedIcon.codePoint,
        ),
      );
      Navigator.pop(context);
      snackbarMessage(context, 'Goal saved!');
    }
  }

  @override
  Widget build(BuildContext context) {
    GoalsRepository goalsRepository = Provider.of<GoalsRepository>(context);

    if (goal != null) {
      nameFieldController.text = goal!.name;
      descriptionFieldController.text = goal!.description;

      iconsCarouselWidget.selectedIcon =
          IconData(goal!.iconId, fontFamily: 'MaterialIcons');

      weekdayButtonsWidget.setSelectedDays(goal!.days);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          goal == null ? 'New Goal' : 'Edit Goal',
          style: const TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 18,
              color: ColorTheme.secondary,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _saveGoal(context, goalsRepository),
            child: const Text(
              'Done',
              style: TextStyle(
                fontSize: 18,
                color: ColorTheme.secondary,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              iconsCarouselWidget,
              const SizedBox(height: 60),
              CustomTextFormFieldWidget(
                controller: nameFieldController,
                maxLength: 24,
                hintText: 'My Goal',
              ),
              const SizedBox(height: 25),
              CustomTextFormFieldWidget(
                controller: descriptionFieldController,
                maxLength: 165,
                maxLines: 5,
                hintText: 'A short description of my goal',
              ),
              const SizedBox(height: 100),
              weekdayButtonsWidget,
            ],
          ),
        ),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      backgroundColor: ColorTheme.background,
    );
  }
}
