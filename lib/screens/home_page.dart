import 'package:flutter/material.dart';

import '../components/goals_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Today\'s Goals',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            size: 32,
          ),
          onPressed: () => Navigator.pushNamed(context, 'MyGoals'),
        ),
      ),
      body: const GoalsListWidget(weekdayFilter: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 32),
        onPressed: () => Navigator.pushNamed(context, 'ManageGoal'),
      ),
    );
  }
}
