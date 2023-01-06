import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/goal_tile_widget.dart';
import '../models/goal.dart';
import '../repositories/goals_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoalsRepository goalsRepository;
  late List<Goal> goals;

  @override
  Widget build(BuildContext context) {
    goalsRepository = Provider.of<GoalsRepository>(context);
    goals = goalsRepository.getGoalsByWeekday(DateTime.now().weekday - 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Habit Tracker',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'My Goals',
              style: TextStyle(fontSize: 28),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: goals.length,
                itemBuilder: (BuildContext context, int index) {
                  return GoalTileWidget(goal: goals[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 32),
        onPressed: () => Navigator.pushNamed(context, 'EditGoal'),
      ),
    );
  }
}
