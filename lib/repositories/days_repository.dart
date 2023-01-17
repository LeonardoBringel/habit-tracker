import 'package:flutter/material.dart';

import '../database/database_manager.dart';
import '../models/day.dart';

class DaysRepository extends ChangeNotifier {
  List<Day> _days = [];
  bool isInitalized = false;

  void _initDays() async {
    _days = await DatabaseManager.instance.fetchDays();
    notifyListeners();
  }

  void updateGoalStatus(DateTime date, var goalId) {
    date = DateUtils.dateOnly(date);
    var day = _getDayByDate(date);

    if (day == null) {
      day = Day(
        completedGoalsId: [goalId],
        date: date,
      );

      _addDay(day);
    } else {
      if (day.completedGoalsId.contains(goalId)) {
        _removeCompletedGoal(day, goalId);
      } else {
        _addCompletedGoal(day, goalId);
      }
    }
  }

  void _addCompletedGoal(var day, var goalId) {
    day.completedGoalsId.add(goalId);
    _updateDay(day);
  }

  void _removeCompletedGoal(var day, var goalId) {
    day!.completedGoalsId.remove(goalId);

    if (day.completedGoalsId.isEmpty) {
      _deleteDay(day);
    } else {
      _updateDay(day);
    }
  }

  void _addDay(var day) async {
    day.id = await DatabaseManager.instance.addDay(day);
    _days.add(day);

    notifyListeners();
  }

  void _updateDay(var day) {
    DatabaseManager.instance.updateDay(day);
    notifyListeners();
  }

  List<Day> _getDays() {
    if (!isInitalized) {
      _initDays();
      isInitalized = true;
    }
    return _days;
  }

  Day? _getDayByDate(DateTime date) {
    date = DateUtils.dateOnly(date);

    var days = _getDays().where((element) => element.date == date);
    if (days.isNotEmpty) {
      return days.first;
    } else {
      return null;
    }
  }

  void _deleteDay(var day) {
    DatabaseManager.instance.deleteDay(day);
    _days.remove(day);
    notifyListeners();
  }

  bool isGoalCompleted(DateTime date, int goalId) {
    date = DateUtils.dateOnly(date);
    var day = _getDayByDate(date);

    if (day != null) {
      return day.completedGoalsId.contains(goalId);
    }
    return false;
  }

  void removeGoal(int goalId) {
    var goalDays = [];

    for (var day in _getDays()) {
      if (day.completedGoalsId.contains(goalId)) {
        goalDays.add(day);
      }
    }

    for (var day in goalDays) {
      _removeCompletedGoal(day, goalId);
    }
  }
}
