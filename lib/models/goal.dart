import 'package:flutter/material.dart';

class Goal {
  final String name;
  final String description;
  final List<String> days;
  final IconData icon;
  final List<String> completedDates;

  const Goal({
    required this.name,
    required this.description,
    required this.days,
    required this.icon,
    required this.completedDates,
  });
}
