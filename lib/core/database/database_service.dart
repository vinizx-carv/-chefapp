import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:chefapp/models/meal_summary_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'chefapp.db');

    return await openDatabase(
      path,
      version: 2, // incrementa a versão
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS favoritos (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        image TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS anotacoes (
        meal_id TEXT PRIMARY KEY,
        texto TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS progresso (
        meal_id TEXT,
        step INTEGER,
        is_done INTEGER,
        PRIMARY KEY (meal_id, step)
      )
    ''');
  }

  // ── favoritos ──────────────────────────────────

  Future<void> saveFavorite(MealSummaryModel meal) async {
    final db = await database;
    await db.insert(
      'favoritos',
      {'id': meal.id, 'name': meal.name, 'image': meal.image},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MealSummaryModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favoritos');

    return maps.map((item) => MealSummaryModel.fromMap({
      'idMeal':       item['id'],
      'strMeal':      item['name'],
      'strMealThumb': item['image'],
    })).toList();
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(
      'favoritos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final result = await db.query(
      'favoritos',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  // ── anotações ──────────────────────────────────

  Future<void> salvarAnotacao(String mealId, String texto) async {
    final db = await database;
    await db.insert(
      'anotacoes',
      {'meal_id': mealId, 'texto': texto},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> buscarAnotacao(String mealId) async {
    final db = await database;
    final result = await db.query(
      'anotacoes',
      where: 'meal_id = ?',
      whereArgs: [mealId],
    );

    if (result.isEmpty) return null;
    return result.first['texto'] as String;
  }

  // ── progresso ──────────────────────────────────

  Future<void> salvarProgresso(String mealId, int step, bool isDone) async {
    final db = await database;
    await db.insert(
      'progresso',
      {
        'meal_id': mealId,
        'step':    step,
        'is_done': isDone ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<int, bool>> buscarProgresso(String mealId) async {
    final db = await database;
    final result = await db.query(
      'progresso',
      where: 'meal_id = ?',
      whereArgs: [mealId],
    );

    return {
      for (final row in result)
        row['step'] as int: row['is_done'] == 1,
    };
  }
}