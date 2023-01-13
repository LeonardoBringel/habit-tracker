import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/day.dart';
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
      version: 2,
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

    await db.execute('''
      CREATE TABLE tb_days(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        completed_goals_id TEXT,
        date TEXT
      );
    ''');
  }

  Future<List<Map<String, dynamic>>> _fetchDatabaseElement(String table) async {
    var database = await instance.database;
    return await database.query(table);
  }

  Future<int?> _addDatabaseElement(String table, var databaseElement) async {
    var database = await instance.database;

    return database.insert(
      table,
      databaseElement.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void _updateDatabaseElement(String table, var databaseElement) async {
    var database = await instance.database;

    database.update(
      table,
      databaseElement.toJson(),
      where: 'id == ${databaseElement.id}',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void _deleteDatabaseElement(String table, var databaseElement) async {
    var database = await instance.database;

    database.delete(
      table,
      where: 'id == ${databaseElement.id}',
    );
  }

  // -- Goals Methods --
  Future<List<Goal>> fetchGoals() async {
    List<Map<String, dynamic>> maps = await _fetchDatabaseElement('tb_goals');

    if (maps.isNotEmpty) {
      return maps.map((map) => Goal.fromJson(map)).toList();
    }
    return [];
  }

  Future<int?> addGoal(var goal) async {
    return await _addDatabaseElement('tb_goals', goal);
  }

  void updateGoal(var goal) async {
    _updateDatabaseElement('tb_goals', goal);
  }

  void deleteGoal(var goal) async {
    _deleteDatabaseElement('tb_goals', goal);
  }

  // -- Days Methods --
  Future<List<Day>> fetchDays() async {
    List<Map<String, dynamic>> maps = await _fetchDatabaseElement('tb_days');

    if (maps.isNotEmpty) {
      return maps.map((map) => Day.fromJson(map)).toList();
    }
    return [];
  }

  Future<int?> addDay(var day) async {
    return await _addDatabaseElement('tb_days', day);
  }

  void updateDay(var day) async {
    _updateDatabaseElement('tb_days', day);
  }

  void deleteDay(var day) async {
    _deleteDatabaseElement('tb_days', day);
  }
}
