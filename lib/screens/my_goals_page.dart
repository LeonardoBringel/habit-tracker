import 'package:flutter/material.dart';

import '../components/goals_list_widget.dart';

class MyGoalsPage extends StatelessWidget {
  const MyGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Habit Tracker',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),
      body: const GoalsListWidget(
        listTitle: 'My Goals',
        weekdayFilter: false,
      ),
    );
  }
}
