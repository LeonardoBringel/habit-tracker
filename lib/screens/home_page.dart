import 'package:flutter/material.dart';
import 'package:habit_tracker/models/goal.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Goal> goals = [
    const Goal(
      name: 'Goal 1',
      description: '',
      frequency: 'Today',
      icon: Icons.auto_awesome,
      completedDates: [],
    ),
    const Goal(
      name: 'Goal 2',
      description: '',
      frequency: 'Daily',
      icon: Icons.auto_awesome,
      completedDates: [],
    ),
    const Goal(
      name: 'Goal 3',
      description: '',
      frequency: 'Daily',
      icon: Icons.auto_awesome,
      completedDates: [],
    ),
    const Goal(
      name: 'Goal 4',
      description: '',
      frequency: 'Weekly',
      icon: Icons.auto_awesome,
      completedDates: [],
    ),
    const Goal(
      name: 'Goal 5',
      description: '',
      frequency: 'Daily',
      icon: Icons.auto_awesome,
      completedDates: [],
    ),
  ];

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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(
                        goals[index].name,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        goals[index].frequency,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      leading: const Icon(Icons.auto_awesome),
                      trailing: const Icon(Icons.check_box_outlined),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
