import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/goals_repository.dart';
import 'goal_tile_widget.dart';

class GoalsListWidget extends StatefulWidget {
  const GoalsListWidget({
    super.key,
    required this.weekdayFilter,
    required this.listTitle,
  });

  final String listTitle;
  final bool weekdayFilter;

  @override
  State<GoalsListWidget> createState() => _GoalsListWidgetState();
}

class _GoalsListWidgetState extends State<GoalsListWidget> {
  late GoalsRepository goalsRepository;
  late List<Goal> goals;

  @override
  Widget build(BuildContext context) {
    goalsRepository = Provider.of<GoalsRepository>(context);

    if (widget.weekdayFilter) {
      goals = goalsRepository.getGoalsByWeekday(DateTime.now().weekday - 1);
    } else {
      goals = goalsRepository.getGoals();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            widget.listTitle,
            style: const TextStyle(fontSize: 28),
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
    );
  }
}
