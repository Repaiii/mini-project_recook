import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:recook/models/recipe.dart';

class RecipeRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'recipe_database.db');
    final database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT, title TEXT, imageUrl TEXT)",
        );
      },
    );
    return database;
  }

  Future<Recipe> addSavedRecipe(Recipe recipe) async {
    final db = await database;
    final recipeMap = recipe.toMap();
    print('=> $recipeMap');
    final id = await db.insert('recipes', recipeMap);
    print('=> $id');
    return recipe.copyWith(id: id);
  }

  Future<void> removeSavedRecipe(int id) async {
    final db = await database;
    await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Recipe>> getSavedRecipes() async {
    final db = await database;
    final result = await db.query('recipes');
    return result.map((map) => Recipe.fromMap(map)).toList();
  }
}
