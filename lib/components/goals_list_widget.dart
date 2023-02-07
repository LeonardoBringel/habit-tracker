import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/days_repository.dart';
import '../repositories/goals_repository.dart';
import '../theme/color_theme.dart';
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

    if (goals.isEmpty) {
      return const EmptyGoalsMessageWidget();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: goals.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              child: widget.weekdayFilter
                  ? _completableGoalTile(index)
                  : _editableGoalTile(index),
              onTap: () {
                if (widget.weekdayFilter) {
                  daysRepository.updateGoalStatus(
                    DateTime.now(),
                    goals[index].id,
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    'Progress',
                    arguments: goals[index],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _editableGoalTile(int index) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Edit',
            icon: Icons.edit,
            backgroundColor: ColorTheme.faded,
            onPressed: (context) {
              Navigator.pushNamed(
                context,
                'ManageGoal',
                arguments: goals[index],
              );
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            icon: Icons.delete,
            backgroundColor: ColorTheme.alert,
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
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: ColorTheme.secondary),
                        ),
                        onPressed: () {
                          daysRepository.removeGoal(goals[index].id);
                          goalsRepository.deleteGoal(goals[index]);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'No',
                          style: TextStyle(color: ColorTheme.secondary),
                        ),
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
      ),
    );
  }

  Widget _completableGoalTile(int index) {
    return GoalTileWidget(
      goal: goals[index],
      isCompleted: daysRepository.isGoalCompleted(
        DateTime.now(),
        goals[index].id,
      ),
    );
  }
}
