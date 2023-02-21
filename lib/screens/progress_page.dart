import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/days_repository.dart';
import '../theme/color_theme.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    DaysRepository daysRepository = Provider.of<DaysRepository>(context);

    var days = daysRepository.getDaysByGoalId(goal.id);
    days.sort((dayA, dayB) => dayB.date.compareTo(dayA.date));

    Map<DateTime, int> dates = {};

    int streak = 0;
    int bestStreak = 0;

    if (days.isNotEmpty) {
      List<DateTime> allDates = _getAllDates(days.last.date, days.first.date);

      for (var date in allDates) {
        if (days.indexWhere((element) => element.date == date) != -1) {
          streak += 1;
          dates.addAll({date: 1});
        } else {
          if (streak > bestStreak) {
            bestStreak = streak;
          }
          streak = 0;
        }
      }
      if (streak > bestStreak) {
        bestStreak = streak;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          goal.name,
          style: TextStyle(fontSize: goal.name.length <= 16 ? 32 : 28),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeatMapCalendar(
              showColorTip: false,
              colorsets: const {
                1: ColorTheme.primary,
              },
              datasets: dates,
              fontSize: 24,
              monthFontSize: 24,
              weekFontSize: 18,
              defaultColor: ColorTheme.faded,
              textColor: ColorTheme.background,
              onClick: (date) {
                if (goal.days[date.weekday - 1] &&
                    date.isBefore(DateTime.now())) {
                  daysRepository.updateGoalStatus(
                    date,
                    goal.id,
                  );
                }
              },
            ),
            const SizedBox(height: 50),
            Icon(
              IconData(
                goal.iconId,
                fontFamily: 'MaterialIcons',
              ),
              size: 48,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Streak',
                        style: TextStyle(fontSize: 32),
                      ),
                      Text(
                        '$streak days',
                        style: const TextStyle(
                          fontSize: 32,
                          color: ColorTheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Container(color: ColorTheme.faded, height: 2),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Best',
                        style: TextStyle(fontSize: 32),
                      ),
                      Text(
                        '$bestStreak days',
                        style: const TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                  Container(color: ColorTheme.faded, height: 2),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: ColorTheme.background,
    );
  }

  List<DateTime> _getAllDates(DateTime firstDate, DateTime lastDate) {
    List<DateTime> allDates = [];

    DateTime today = DateUtils.dateOnly(DateTime.now());
    DateTime date = firstDate;

    while (date.compareTo(today) <= 0) {
      if (goal.days[date.weekday - 1]) {
        allDates.add(date);
      }
      date = date.add(const Duration(days: 1));
    }
    return allDates;
  }
}
