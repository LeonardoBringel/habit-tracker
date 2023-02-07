import 'package:flutter/material.dart';

import '../components/goals_list_widget.dart';
import '../theme/color_theme.dart';

class MyGoalsPage extends StatelessWidget {
  const MyGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Goals',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),
      body: const GoalsListWidget(weekdayFilter: false),
      backgroundColor: ColorTheme.background,
    );
  }
}
