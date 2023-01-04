import 'package:flutter/material.dart';

class Goal {
  final int id;
  final String name;
  final String description;
  final List<int> days;
  final IconData icon;
  final List<String> completedDates;

  const Goal({
    this.id = -1,
    required this.name,
    required this.description,
    required this.days,
    required this.icon,
    required this.completedDates,
  });
}
