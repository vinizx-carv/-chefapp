import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:chefapp/models/meal_summary_model.dart';

class DatabaseService {
  static Database? _database;

  // inicializa o banco
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'chefapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favoritos (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            image TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // salva uma receita nos favoritos
  Future<void> saveFavorite(MealSummaryModel meal) async {
    final db = await database;
    await db.insert(
      'favoritos',
      {'id': meal.id, 'name': meal.name, 'image': meal.image},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // busca todas as receitas favoritas
  Future<List<MealSummaryModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favoritos');

    return maps.map((item) => MealSummaryModel.fromMap({
      'idMeal':       item['id'],
      'strMeal':      item['name'],
      'strMealThumb': item['image'],
    })).toList();
  }

  // remove uma receita dos favoritos
  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(
      'favoritos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // verifica se uma receita já é favorita
  Future<bool> isFavorite(String id) async {
    final db = await database;
    final result = await db.query(
      'favoritos',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}