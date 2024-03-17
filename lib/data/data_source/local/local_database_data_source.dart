import 'package:bloc_clean_architecture/core/services/database_services.dart';
import 'package:bloc_clean_architecture/data/models/product/cart_item_model.dart';

abstract class LocalDatabaseDataSource {
  Future<CartItemModel> createCartItem(CartItemModel params);

  Future<List<CartItemModel>> getAllCartItem();

  Future<int> deleteCartItem(int? id);

  Future closeDb();

  Future<void> deleteDatabase(String path);
}

class LocalDatabaseDataSourceImpl implements LocalDatabaseDataSource {
  final DatabaseService databaseService;

  LocalDatabaseDataSourceImpl(this.databaseService);

  @override
  Future<CartItemModel> createCartItem(CartItemModel params) async {
    return await databaseService.createCartItem(params);
  }

  @override
  Future<int> deleteCartItem(int? id) async {
    return await databaseService.deleteCartItem(id!);
  }

  @override
  Future<List<CartItemModel>> getAllCartItem() async {
    return await databaseService.getAllCartItem();
  }

  @override
  Future closeDb() async {
    return await databaseService.closeDatabase();
  }

  @override
  Future<void> deleteDatabase(String path) async {
    return await databaseService.deleteDatabase(path);
  }
}
