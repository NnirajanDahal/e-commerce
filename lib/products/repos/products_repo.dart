import 'package:ecommerce_app/products/models/product_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsRepo {
  final String productUrl = "https://dummyjson.com/products";
  Future<List<ProductModel>> fetchProducts() async {
    var client = http.Client();
    List<ProductModel> products = [];
    try {
      var response = await client.get(Uri.parse(productUrl));
      print(response.body);
      Map<String, dynamic> result = jsonDecode(response.body);
      // products = result.map((e) => ProductModel.fromJson(e)).toList();
      for (int i = 0; i < result.length; i++) {
        ProductModel product = ProductModel.fromJson(result);
        products.add(product);
      }
      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Product?> fetchProductsDetail(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse("$productUrl/$id"));
      print(response.body);
      Map<String, dynamic> result = jsonDecode(response.body);
      // products = result.map((e) => ProductModel.fromJson(e)).toList();
      Product product = Product.fromJson(result);
      return product;
    } catch (e) {
      return null;
    }
  }
}
