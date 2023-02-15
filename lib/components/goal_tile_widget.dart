import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/days_repository.dart';
import '../repositories/goals_repository.dart';
import '../theme/color_theme.dart';

class GoalTileWidget extends StatefulWidget {
  const GoalTileWidget({
    super.key,
    required this.goal,
    this.isSlidable = false,
  });

  final Goal goal;
  final bool isSlidable;

  @override
  State<GoalTileWidget> createState() => _GoalTileWidgetState();
}

class _GoalTileWidgetState extends State<GoalTileWidget> {
  late GoalsRepository goalsRepository;
  late DaysRepository daysRepository;

  @override
  Widget build(BuildContext context) {
    goalsRepository = Provider.of<GoalsRepository>(context);
    daysRepository = Provider.of<DaysRepository>(context);

    bool isGoalCompleted = false;
    if (!widget.isSlidable) {
      isGoalCompleted = daysRepository.isGoalCompleted(
        DateTime.now(),
        widget.goal.id,
      );
    }

    return InkWell(
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isGoalCompleted ? ColorTheme.faded : ColorTheme.secondary,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Slidable(
            enabled: widget.isSlidable,
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
                      arguments: widget.goal,
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
                          content: const Text(
                              'Are you sure about deleting this goal?'),
                          actions: [
                            TextButton(
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: ColorTheme.secondary),
                              ),
                              onPressed: () {
                                daysRepository.removeGoal(widget.goal.id);
                                goalsRepository.deleteGoal(widget.goal);
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
            child: ListTile(
              leading: SizedBox(
                width: 70,
                height: 70,
                child: Icon(
                  IconData(
                    widget.goal.iconId,
                    fontFamily: 'MaterialIcons',
                  ),
                  size: 32,
                  color:
                      isGoalCompleted ? ColorTheme.faded : ColorTheme.primary,
                ),
              ),
              title: Text(
                widget.goal.name,
                style: TextStyle(
                  fontSize: widget.goal.name.length <= 20 ? 24 : 20,
                  decoration:
                      isGoalCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(
                widget.goal.days.contains(false)
                    ? widget.goal
                        .getWeekdays()
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                    : 'DAILY',
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        if (widget.isSlidable) {
          Navigator.pushNamed(
            context,
            'Progress',
            arguments: widget.goal,
          );
        } else {
          daysRepository.updateGoalStatus(
            DateTime.now(),
            widget.goal.id,
          );
        }
      },
    );
  }
}
