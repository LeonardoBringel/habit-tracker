import 'package:flutter/material.dart';

class Goal {
  final int id;
  final String name;
  final String description;
  final List<bool> days;
  final IconData icon;

  const Goal({
    this.id = -1,
    required this.name,
    required this.description,
    required this.days,
    required this.icon,
  });
}
