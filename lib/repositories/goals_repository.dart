import 'package:flutter/material.dart';

import '../database/database_manager.dart';
import '../models/goal.dart';

class GoalsRepository extends ChangeNotifier {
  List<Goal> _goals = [];

  void _initGoals() async {
    _goals = await DatabaseManager.instance.fetchGoals();
    notifyListeners();
  }

  void saveGoal(var goal) {
    if (goal.id != -1) {
      // TODO update goal
      return;
    }
    _addGoal(goal);
  }

  void _addGoal(var goal) async {
    goal.id = await DatabaseManager.instance.addGoal(goal);
    _goals.add(goal);
    notifyListeners();
  }

  List<Goal> getGoals() {
    if (_goals.isEmpty) {
      _initGoals();
    }

    return _goals;
  }

  List<Goal> getGoalsByWeekday(int weekday) {
    List<Goal> filteredGoals = [];

    for (var goal in getGoals()) {
      if (goal.days[weekday]) {
        filteredGoals.add(goal);
      }
    }
    return filteredGoals;
  }
}
