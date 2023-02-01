import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

import '../models/goal.dart';
import '../repositories/days_repository.dart';

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
    List<int> streaks = [];

    if (days.isNotEmpty) {
      DateTime lastDay;
      lastDay = days.first.date;
      for (var day in days) {
        int difference = day.date.difference(lastDay).inDays;
        if (difference == -1 || difference == 0) {
          streak += 1;
        } else {
          streaks.add(streak);
          streak = 1;
        }
        lastDay = day.date;
        dates.addAll({day.date: 1});
      }
      streaks.add(streak);

      DateTime today = DateUtils.dateOnly(DateTime.now());
      if (days.first.date.compareTo(today) == 0) {
        streak = streaks.first;
      } else {
        streak = 0;
      }
    }

    for (int i in streaks) {
      if (bestStreak < i) {
        bestStreak = i;
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
                1: Colors.yellow,
              },
              datasets: dates,
              fontSize: 24,
              monthFontSize: 24,
              weekFontSize: 18,
              defaultColor: Colors.grey,
              textColor: Colors.black,
              onClick: (date) {
                if (date.isBefore(DateTime.now())) {
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
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                  Container(color: Colors.grey, height: 2),
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
                  Container(color: Colors.grey, height: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
