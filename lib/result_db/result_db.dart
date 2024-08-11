import 'package:path/path.dart';
import 'package:quiz/model/result_model.dart';
import 'package:sqflite/sqflite.dart';

class ResultDB {
  // Singleton pattern
  static final ResultDB _databaseService = ResultDB.internal();
  factory ResultDB() => _databaseService;
  ResultDB.internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase(1);
    return _database!;
  }

  Future<Database> _initDatabase(int version) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'resultDB.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: version,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  ///TODO: створює таблицю в базі даних
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ResultDB(id INTEGER PRIMARY KEY, result TEXT, correctAnswers TEXT)',
    );
  }

  ///TODO: create
  Future<void> createResultDB(ResultModel resultModel) async {
    final db = await _databaseService.database;
    await db.insert(
      'ResultDB',
      resultModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///TODO: get db
  Future<List<ResultModel>> getResultDB() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('ResultDB');
    return List.generate(maps.length, (index) => ResultModel.fromMap(maps[index]));
  }

  ///TODO: delete db
  Future<void> deleteSelectCardsDB(List<ResultModel> resultModel) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'resultDB.db');
    await databaseFactory.deleteDatabase(path);
  }

  ///TODO: delete item from db
  Future<void> deleteItem(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      "ResultDB",     // replace with table name
      where: "id = ?",
      whereArgs: [id],   // you need the id
    );
  }

  Future<bool> databaseExists() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'resultDB.db');
    return databaseFactory.databaseExists(path);
  }
}