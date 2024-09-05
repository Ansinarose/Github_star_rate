import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/repository_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'repositories.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE repositories(id INTEGER PRIMARY KEY,name TEXT, description TEXT, stars INTEGER, ownerUsername TEXT, ownerAvatarUrl TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertRepository(Repository repository) async {
    final db = await database;
    await db.insert(
      'repositories',
      repository.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Repository>> getRepositories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('repositories');

    return List.generate(maps.length, (i) {
      return Repository(
        name: maps[i]['name'],
        description: maps[i]['description'],
        stars: maps[i]['stars'],
        ownerUsername: maps[i]['ownerUsername'],
        ownerAvatarUrl: maps[i]['ownerAvatarUrl'],
      );
    });
  }
}
