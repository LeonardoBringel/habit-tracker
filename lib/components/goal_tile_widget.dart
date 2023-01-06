import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/goals_repository.dart';

class GoalTileWidget extends StatefulWidget {
  const GoalTileWidget({Key? key, required this.goal}) : super(key: key);

  final Goal goal;

  @override
  State<GoalTileWidget> createState() => _GoalTileWidgetState();
}

class _GoalTileWidgetState extends State<GoalTileWidget> {
  late GoalsRepository goalsRepository;

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
    goalsRepository = Provider.of<GoalsRepository>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              label: 'Delete',
              icon: Icons.delete,
              backgroundColor: Colors.red.shade900,
              onPressed: (context) {
                goalsRepository.deleteGoal(widget.goal);
              },
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            widget.goal.name,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            widget.goal.days.contains(false)
                ? weekdays[DateTime.now().weekday]!
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
          trailing: const Icon(Icons.check_box_outlined),
        ),
      ),
    );
  }
}
