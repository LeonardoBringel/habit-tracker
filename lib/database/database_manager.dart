import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/goal.dart';

class DatabaseManager {
  DatabaseManager._privateConstructor();

  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var documentsPath = (await getApplicationDocumentsDirectory()).path;
    var databasePath = '${documentsPath}HabitTracker.db';

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tb_goals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        is_on_monday BOOLEAN,
        is_on_tuesday BOOLEAN,
        is_on_wednesday BOOLEAN,
        is_on_thursday BOOLEAN,
        is_on_friday BOOLEAN,
        is_on_saturday BOOLEAN,
        is_on_sunday BOOLEAN,
        icon_id INTEGER
      );
    ''');
  }

  Future<List<Goal>> fetchGoals() async {
    Database database = await instance.database;

    List<Map<String, dynamic>> maps = await database.query('tb_goals');

    if (maps.isNotEmpty) {
      return maps.map((map) => Goal.fromJson(map)).toList();
    }
    return [];
  }

  Future<int?> addGoal(var goal) async {
    Database database = await instance.database;

    return database.insert(
      'tb_goals',
      goal.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void deleteGoal(var goal) async {
    Database database = await instance.database;

    database.delete(
      'tb_goals',
      where: 'id == ${goal.id}',
    );
  }
}
