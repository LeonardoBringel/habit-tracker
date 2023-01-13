import 'database_element.dart';

class Day implements DatabaseElement {
  @override
  int id;

  final List<int> completedGoalsId;
  final DateTime date;

  Day({
    this.id = -1,
    required this.completedGoalsId,
    required this.date,
  });

  @override
  Day.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        completedGoalsId = (json['completed_goals_id'].split(', ') as List)
            .map((item) => int.parse(item))
            .toList(),
        date = DateTime.parse(json['date']);

  @override
  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'id': id,
      'completed_goals_id':
          completedGoalsId.toString().replaceAll('[', '').replaceAll(']', ''),
      'date': date.toString(),
    };

    if (id == -1) {
      json.remove('id');
    }

    return json;
  }
}
