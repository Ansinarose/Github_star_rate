import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '../models/repository_model.dart';

class DatabaseService {
  // Singleton instance of DatabaseService.
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  // The database instance.
  Database? _database;

  // Lazy initialization of the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database and creates the tables.
  Future<Database> _initDatabase() async {
    // Path to the database file.
    String path = join(await getDatabasesPath(), 'repositories.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        // SQL command to create the repositories table.
        await db.execute('''  
          CREATE TABLE repositories(
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            stars INTEGER,
            ownerUsername TEXT,
            ownerAvatarUrl TEXT,
            localAvatarPath TEXT
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // SQL command to add a new column in an existing table if database version is upgraded.
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE repositories ADD COLUMN localAvatarPath TEXT');
        }
      },
    );
  }

  // Downloads an image from a URL and saves it locally.
  Future<String> _downloadAndSaveImage(String imageUrl) async {
    try {
      print("Downloading image from: $imageUrl");
      final response = await http.get(Uri.parse(imageUrl));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final fileName = imageUrl.split('/').last;
      final filePath = '${documentDirectory.path}/$fileName';
      File(filePath).writeAsBytesSync(response.bodyBytes);
      print("Image saved to: $filePath");
      return filePath;
    } catch (e) {
      print("Error downloading/saving image: $e");
      return "";
    }
  }

  // Inserts a repository into the database, including downloading and saving the owner's avatar image.
  Future<void> insertRepository(Repository repository) async {
    final db = await database;
    // Download and save the repository owner's avatar image.
    String localAvatarPath = await _downloadAndSaveImage(repository.ownerAvatarUrl);
    await db.insert(
      'repositories',
      {
        ...repository.toMap(),
        'localAvatarPath': localAvatarPath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieves all repositories from the database.
  Future<List<Repository>> getRepositories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('repositories');

    // Converts the query result into a list of Repository objects.
    return List.generate(maps.length, (i) {
      return Repository(
        name: maps[i]['name'],
        description: maps[i]['description'],
        stars: maps[i]['stars'],
        ownerUsername: maps[i]['ownerUsername'],
        ownerAvatarUrl: maps[i]['ownerAvatarUrl'],
        localAvatarPath: maps[i]['localAvatarPath'],
      );
    });
  }
}
