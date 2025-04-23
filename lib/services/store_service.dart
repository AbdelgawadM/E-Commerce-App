import 'package:dio/dio.dart';
import 'package:e_commerce/models/product_model.dart';

class StoreService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://dummyjson.com/products/category-list'; // replace this with your real endpoint

  Future<List> fetchCategories() async {
    try {
      final response = await _dio.get(_baseUrl);
      List<dynamic> categories = response.data;

      if (response.statusCode == 200) {
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<ProductModel>> fetchProducts(String category) async {
    try {
      final response = await _dio.get(
        "https://dummyjson.com/products/category/$category", // استبدل بالرابط الصحيح لو عندك
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data['products'];
        List<ProductModel> productList =
            jsonList.map((e) => ProductModel.fromJson(e)).toList();
        return productList;
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
