import 'package:ecommerce_app/cart/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartRepo {
  Future<String> storeCartData(
      int cartId,
      String productTitle,
      int productPrice,
      int productQuantity,
      int productTotalAmount,
      String productThumbnail) async {
    List<CartModel> carts = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('cartData');
      String? userID = prefs.getString('userID');
      if (jsonString != null) {
        try {
          final jsonData = jsonDecode(jsonString);
          if (jsonData is List<dynamic>) {
            carts = jsonData.map((json) => CartModel.fromJson(json)).toList();
          } else if (jsonData is Map<String, dynamic>) {
            carts.add(CartModel.fromJson(jsonData));
          }
        } catch (e) {
          print("Error data: $e");
        }
      }
      if (userID != null) {
        CartModel cart = CartModel(
            cartId: cartId,
            userId: int.parse(userID),
            productTitle: productTitle,
            productPrice: productPrice,
            productQuantity: productQuantity,
            productTotalAmount: productTotalAmount,
            productThumbnail: productThumbnail);
        carts.add(cart);
      }
      List<Map<String, dynamic>> jsonDataList =
          carts.map((cart) => cart.toJson()).toList();
      String jsonData = json.encode(jsonDataList);
      await prefs.setString('cartData', jsonData);
      return "Carton Added";
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<CartModel>> fetchCartData() async {
    List<CartModel> carts = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('cartData');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();

        carts = decodedData.map((e) => CartModel.fromJson(e)).toList();
      } catch (e) {
        print("error ${e}");
      }
      return carts;
      // return dataList;
    } else {
      return carts = [];
    }
  }

  Future<List<CartModel>> deleteCartData(String productTitle) async {
    List<CartModel> carts = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('cartData');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();

        carts = decodedData.map((e) => CartModel.fromJson(e)).toList();
      } catch (e) {
        print("error ${e}");
      }
      int indexToUpdate =
          carts.indexWhere((element) => element.productTitle == productTitle);
      if (indexToUpdate != -1) {
        carts.removeAt(indexToUpdate);
      } else {
        print("Not Found");
      }
      List<Map<String, dynamic>> jsonDataList =
          carts.map((cv) => cv.toJson()).toList();
      print(jsonDataList);
      String jsonDataString = json.encode(jsonDataList);
      prefs.setString('cartData', jsonDataString);

      return carts;
      // return dataList;
    } else {
      return carts = [];
    }
  }

  Future<List<CartModel>> confirmCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartData');
    return [];
  }
}
