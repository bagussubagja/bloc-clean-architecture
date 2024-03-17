import 'package:bloc_clean_architecture/data/models/product/cart_item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableCart (
      ${CartItem.id} $idType,
      ${CartItem.productId} $textType UNIQUE,
      ${CartItem.productName} $textType,
      ${CartItem.productPrice} $textType,
      ${CartItem.productImage} $textType
      )
      ''');
  }

  Future<CartItemModel> createCartItem(CartItemModel params) async {
    final db = await instance.database;

    final existingCartItem = await db.query(
      tableCart,
      where: '${CartItem.productId} = ?',
      whereArgs: [params.productId],
    );

    if (existingCartItem.isEmpty) {
      final item = await db.insert(
        tableCart,
        params.toJson(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return params.copy(id: item);
    } else {
      throw Exception(
          'A cart item with productId ${params.productName} already exists.');
    }
  }

  Future<List<CartItemModel>> getAllCartItem() async {
    final db = await instance.database;
    final result = await db.query(tableCart);
    return result.map((json) => CartItemModel.fromJson(json)).toList();
  }

  Future<int> deleteCartItem(int? id) async {
    final db = await instance.database;
    return await db
        .delete(tableCart, where: '${CartItem.id} = ?', whereArgs: [id]);
  }

  Future closeDatabase() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> deleteDatabase(String path) async {
    final database = await instance.database;
    database.delete(tableCart);
  }
}
