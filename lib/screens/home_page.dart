import 'package:flutter/material.dart';

import '../components/goal_tile_widget.dart';
import '../database/database_manager.dart';
import '../models/goal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Goal> goals = [];

  void _fetchGoals() async {
    goals = await DatabaseManager.instance.fetchGoals();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchGoals();
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
                  if (goals[index].days[DateTime.now().weekday - 1]) {
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
          bool isModified =
              await Navigator.pushNamed(context, 'EditGoal') as bool;

          if (isModified) {
            _fetchGoals();
          }
        },
      ),
    );
  }
}
