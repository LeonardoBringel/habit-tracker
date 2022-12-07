import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/edit_goal_page.dart';
import 'package:habit_tracker/screens/home_page.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: const HomePage(),
      routes: {
        'Home': (context) => const HomePage(),
        'EditGoal': (context) => const EditGoalPage(),
      },
    );
  }
}
