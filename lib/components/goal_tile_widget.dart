import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/days_repository.dart';

class GoalTileWidget extends StatefulWidget {
  const GoalTileWidget({
    super.key,
    required this.goal,
    this.isGoalEditable = false,
  });

  final Goal goal;
  final bool isGoalEditable;

  static const Map<int, String> weekdays = {
    1: 'MON',
    2: 'TUE',
    3: 'WED',
    4: 'THU',
    5: 'FRI',
    6: 'SAT',
    7: 'SUN',
  };

  @override
  State<GoalTileWidget> createState() => _GoalTileWidgetState();
}

class _GoalTileWidgetState extends State<GoalTileWidget> {
  late DaysRepository daysRepository;

  @override
  Widget build(BuildContext context) {
    daysRepository = Provider.of<DaysRepository>(context);

    return InkWell(
      child: ListTile(
        title: Text(
          widget.goal.name,
          style:
              daysRepository.isGoalCompleted(DateTime.now(), widget.goal.id) &
                      !widget.isGoalEditable
                  ? const TextStyle(
                      fontSize: 24, decoration: TextDecoration.lineThrough)
                  : const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          widget.goal.days.contains(false)
              ? GoalTileWidget.weekdays[DateTime.now().weekday]!
              : 'Daily',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        leading: Icon(
          IconData(
            widget.goal.iconId,
            fontFamily: 'MaterialIcons',
          ),
        ),
      ),
      onTap: () {
        if (widget.isGoalEditable) {
          Navigator.pushNamed(
            context,
            'ManageGoal',
            arguments: widget.goal,
          );
        } else {
          daysRepository.updateGoalStatus(DateTime.now(), widget.goal.id);
        }
      },
    );
  }
}
