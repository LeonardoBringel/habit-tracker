import 'package:flutter/material.dart';

import '../models/goal.dart';

class GoalTileWidget extends StatelessWidget {
  const GoalTileWidget({super.key, required this.goal});

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
    return InkWell(
      child: ListTile(
        title: Text(
          goal.name,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          goal.days.contains(false)
              ? weekdays[DateTime.now().weekday]!
              : 'Daily',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        leading: Icon(
          IconData(
            goal.iconId,
            fontFamily: 'MaterialIcons',
          ),
        ),
        trailing: const Icon(Icons.check_box_outlined),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          'ManageGoal',
          arguments: goal,
        );
      },
    );
  }
}
