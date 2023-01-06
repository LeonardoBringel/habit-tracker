import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repositories/goals_repository.dart';
import 'screens/home_page.dart';
import 'screens/manage_goal_page.dart';
import 'screens/my_goals_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GoalsRepository(),
      child: const HabitTrackerApp(),
    ),
  );
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
        'MyGoals': (context) => const MyGoalsPage(),
      },
    );
  }
}
