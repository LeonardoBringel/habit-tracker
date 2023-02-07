import 'database_element.dart';

class Goal implements DatabaseElement {
  @override
  int id;

  final String name;
  final String description;
  final List<bool> days;
  final int iconId;

  Goal({
    this.id = -1,
    required this.name,
    required this.description,
    required this.days,
    required this.iconId,
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
        iconId = json['icon_id'];

  @override
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
      'icon_id': iconId,
    };

    if (id == -1) {
      json.remove('id');
    }

    return json;
  }

  List<String> getWeekdays() {
    const Map<int, String> weekdays = {
      1: 'MON',
      2: 'TUE',
      3: 'WED',
      4: 'THU',
      5: 'FRI',
      6: 'SAT',
      7: 'SUN',
    };

    List<String> result = [];

    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        result.add(weekdays[i + 1]!);
      }
    }

    return result;
  }
}
