import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/days_repository.dart';
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
  late DaysRepository daysRepository;
  late List<Goal> goals;

  @override
  Widget build(BuildContext context) {
    goalsRepository = Provider.of<GoalsRepository>(context);
    daysRepository = Provider.of<DaysRepository>(context);

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
          _listViewBuilder(),
        ],
      ),
    );
  }

  Widget _listViewBuilder() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: goals.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: widget.weekdayFilter
                ? _completableGoalTile(index)
                : _editableGoalTile(index),
          );
        },
      ),
    );
  }

  Widget _editableGoalTile(int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            icon: Icons.delete,
            backgroundColor: Colors.red.shade900,
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Caution'),
                    content:
                        const Text('Are you sure about deleting this goal?'),
                    actions: [
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          daysRepository.removeGoal(goals[index].id);
                          goalsRepository.deleteGoal(goals[index]);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      child: GoalTileWidget(
        goal: goals[index],
        isGoalEditable: true,
      ),
    );
  }

  Widget _completableGoalTile(int index) {
    return GoalTileWidget(
      goal: goals[index],
    );
  }
}
