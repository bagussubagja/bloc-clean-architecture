import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/data/models/category/categories_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  Future<List<CategoriesModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CategoriesModel>> getCategories() async {
    final response = await client
        .get(Uri.parse('https://api.escuelajs.co/api/v1/categories/'));
    if (response.statusCode == 200) {
      return categoriesModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
