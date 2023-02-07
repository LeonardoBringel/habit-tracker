import 'package:flutter/material.dart';

import '../models/goal.dart';
import '../theme/color_theme.dart';

class GoalTileWidget extends StatelessWidget {
  const GoalTileWidget({
    super.key,
    required this.goal,
    this.isCompleted = false,
  });

  final Goal goal;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2,
          color: isCompleted ? ColorTheme.faded : ColorTheme.secondary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 35,
        child: Icon(
          IconData(
            goal.iconId,
            fontFamily: 'MaterialIcons',
          ),
          size: 32,
          color: isCompleted ? ColorTheme.faded : ColorTheme.primary,
        ),
      ),
      title: Text(
        goal.name,
        style: TextStyle(
          fontSize: goal.name.length <= 20 ? 24 : 20,
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        goal.days.contains(false)
            ? goal
                .getWeekdays()
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '')
            : 'DAILY',
      ),
    );
  }
}
