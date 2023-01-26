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
          goals.isNotEmpty ? _listViewBuilder() : _emptyGoalsMessage(),
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
            backgroundColor: Colors.grey,
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

  Widget _emptyGoalsMessage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
      child: Column(
        children: [
          Image.asset(
            'assets/images/spooky_ghost.png',
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 50),
          const Text(
            'Oooooops!',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          const Text(
            'This place looks empty, let\'s create some goals before more ghosts arrive!',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
