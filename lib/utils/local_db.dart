import 'package:restaurant_dicoding/models/detail_restaurant_response.dart';
import 'package:restaurant_dicoding/models/list_restaurant_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDb {
  static late Database _database;

  static const String _tableName = 'favorite_restaurant';

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    String path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite_restaurant.db'),
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_tableName (id TEXT PRIMARY KEY, name TEXT, description TEXT, city TEXT, pictureId TEXT, rating TEXT)''');
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertRestaurant(DetailRestaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);
    return result
        .map(
          (e) => Restaurant(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            pictureId: e['pictureId'],
            city: e['city'],
            rating: double.parse(e['rating']),
          ),
        )
        .toList();
  }

  Future<bool> getIsRestaurantFavorite(String id) async {
    final Database db = await database;
    final data = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return data.isNotEmpty;
  }

  Future<void> deleteRestaurantFromFavorite(String id) async {
    final Database db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
