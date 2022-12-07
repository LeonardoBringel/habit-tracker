import 'package:flutter/material.dart';
import 'package:habit_tracker/models/goal.dart';

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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(
                        goals[index].name,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        goals[index].days.toString(),
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
