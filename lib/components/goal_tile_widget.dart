import 'package:flutter/material.dart';

import '../models/goal.dart';

class GoalTileWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        goal.name,
        style: isCompleted
            ? const TextStyle(
                fontSize: 24, decoration: TextDecoration.lineThrough)
            : const TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      subtitle: Text(
        goal.days.contains(false) ? weekdays[DateTime.now().weekday]! : 'Daily',
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      leading: Icon(
        IconData(
          goal.iconId,
          fontFamily: 'MaterialIcons',
        ),
      ),
    );
  }
}
