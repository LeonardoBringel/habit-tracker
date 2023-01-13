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

    if (day != null) {
      if (day.completedGoalsId.contains(goalId)) {
        _removeCompletedGoal(date, goalId);
      } else {
        _addCompletedGoal(date, goalId);
      }
    } else {
      _addCompletedGoal(date, goalId);
    }
  }

  void _addCompletedGoal(DateTime date, var goalId) {
    for (var day in _getDays()) {
      if (day.date == date) {
        day.completedGoalsId.add(goalId);
        _updateDay(day);
      }
    }

    _addDay(
      Day(
        completedGoalsId: [goalId],
        date: date,
      ),
    );
  }

  void _removeCompletedGoal(DateTime date, var goalId) {
    var day = _getDayByDate(date);

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
}
