import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/data/models/product/products_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductsModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<List<ProductsModel>> getProducts() async {
    final response = await client
        .get(Uri.parse('https://api.escuelajs.co/api/v1/products/'));
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
