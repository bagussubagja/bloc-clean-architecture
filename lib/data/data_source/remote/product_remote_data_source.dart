import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/data/models/product/detail_product_model.dart';
import 'package:bloc_clean_architecture/data/models/product/products_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductsModel>> getProducts();
  Future<DetailProductModel> getDetailProduct(int id);
  Future<List<ProductsModel>> getProductsByCategory(int id);
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

  @override
  Future<DetailProductModel> getDetailProduct(int id) async {
    final response = await client
        .get(Uri.parse('https://api.escuelajs.co/api/v1/products/$id'));
    if (response.statusCode == 200) {
      return detailProductModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductsModel>> getProductsByCategory(int id) async {
   final response = await client.get(Uri.parse('https://api.escuelajs.co/api/v1/categories/$id/products'));
   if (response.statusCode == 200) {
     return productsModelFromJson(response.body);
   } else {
     throw ServerException();
   }
  }
}
