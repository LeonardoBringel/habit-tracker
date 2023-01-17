import 'package:flutter/material.dart';

import '../models/goal.dart';

class GoalTileWidget extends StatefulWidget {
  const GoalTileWidget({
    super.key,
    required this.goal,
    this.isCompleted = false,
  });

  final Goal goal;
  final bool isCompleted;

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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.goal.name,
        style: widget.isCompleted
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
    );
  }
}
