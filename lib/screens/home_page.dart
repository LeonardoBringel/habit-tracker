import 'package:flutter/material.dart';
import 'package:habit_tracker/models/goal.dart';

import '../components/goal_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Goal> goals = [];

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
                  if (goals[index].days.contains(DateTime.now().weekday)) {
                    return GoalTileWidget(goal: goals[index]);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 32),
        onPressed: () async {
          Goal? goal = await Navigator.pushNamed(context, 'EditGoal') as Goal?;
          if (goal != null) {
            setState(() {
              goals.add(goal);
            });
          }
        },
      ),
    );
  }
}
