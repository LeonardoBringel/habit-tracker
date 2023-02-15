import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/goals_repository.dart';
import 'empty_goals_message_widget.dart';
import 'goal_tile_widget.dart';

class GoalsListWidget extends StatefulWidget {
  const GoalsListWidget({super.key, required this.weekdayFilter});

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

    if (goals.isEmpty) {
      return const EmptyGoalsMessageWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(28),
      itemCount: goals.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GoalTileWidget(
            goal: goals[index],
            isSlidable: !widget.weekdayFilter,
          ),
        );
      },
    );
  }
}
