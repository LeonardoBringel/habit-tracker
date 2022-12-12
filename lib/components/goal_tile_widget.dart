import 'package:flutter/material.dart';

import '../models/goal.dart';

class GoalTileWidget extends StatelessWidget {
  const GoalTileWidget({Key? key, required this.goal}) : super(key: key);

  final Goal goal;

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          goal.name,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          goal.days.length == 7 ? 'Daily' : weekdays[DateTime.now().weekday]!,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        leading: const Icon(Icons.auto_awesome),
        trailing: const Icon(Icons.check_box_outlined),
      ),
    );
  }
}
