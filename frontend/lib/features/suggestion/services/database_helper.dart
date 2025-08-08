// lib/features/suggestion/services/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SuggestionsDB {
  static final SuggestionsDB instance = SuggestionsDB._init();
  static Database? _database;

  SuggestionsDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('suggestions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE suggestions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        suggestion TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
    // Add a new table for the API key
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY,
        apiKey TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertSuggestion(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('suggestions', data);
  }

  Future<List<Map<String, dynamic>>> fetchSuggestions() async {
    final db = await instance.database;
    return await db.query('suggestions', orderBy: 'id DESC');
  }

  // New method to insert or update the API key
  Future<void> insertApiKey(String apiKey) async {
    final db = await instance.database;
    await db.insert(
      'settings',
      {'id': 1, 'apiKey': apiKey}, // Using a fixed ID to ensure only one key
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // New method to get the API key
  Future<String?> getApiKey() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'settings',
      where: 'id = ?',
      whereArgs: [1],
    );
    if (maps.isNotEmpty) {
      return maps.first['apiKey'] as String;
    }
    return null;
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
    _database = null; // Reset the database instance
  }
}
