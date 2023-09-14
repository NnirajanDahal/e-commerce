import 'package:ecommerce_app/products/models/product_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchRepo {
  static Future<List<ProductModel>> fetchProducts(String query) async {
    var client = http.Client();
    List<ProductModel> searchProducts = [];
    try {
      var response = await client
          .get(Uri.parse("https://dummyjson.com/products/search?q=$query"));
      print(response.body);
      Map<String, dynamic> result = jsonDecode(response.body);
      // products = result.map((e) => ProductModel.fromJson(e)).toList();
      for (int i = 0; i < result.length; i++) {
        ProductModel product = ProductModel.fromJson(result);
        searchProducts.add(product);
      }
      return searchProducts;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
