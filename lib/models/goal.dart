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

  Goal.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        days = [
          json['is_on_monday'] == 1,
          json['is_on_tuesday'] == 1,
          json['is_on_wednesday'] == 1,
          json['is_on_thursday'] == 1,
          json['is_on_friday'] == 1,
          json['is_on_saturday'] == 1,
          json['is_on_sunday'] == 1,
        ],
        icon = IconData(json['icon']);

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'is_on_monday': days[0],
      'is_on_tuesday': days[1],
      'is_on_wednesday': days[2],
      'is_on_thursday': days[3],
      'is_on_friday': days[4],
      'is_on_saturday': days[5],
      'is_on_sunday': days[6],
      'icon': icon.codePoint,
    };

    if (id == -1) {
      json.remove('id');
    }

    return json;
  }
}
