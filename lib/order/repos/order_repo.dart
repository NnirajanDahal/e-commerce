import 'dart:convert';

import 'package:ecommerce_app/order/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cart/model/cart_model.dart';

class OrderRepo {
  Future<String> storeOrderData(int orderId, String dateTime, int totalAmount,
      List<CartModel> carts) async {
    List<OrderModel> orderList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('orderData');
      if (jsonString != null) {
        try {
          final jsonData = jsonDecode(jsonString);
          if (jsonData is List<dynamic>) {
            orderList =
                jsonData.map((json) => OrderModel.fromJson(json)).toList();
          } else if (jsonData is Map<String, dynamic>) {
            orderList.add(OrderModel.fromJson(jsonData));
          }
        } catch (e) {
          print("Error data: $e");
        }
      }
      OrderModel order = OrderModel(
          orderId: orderId,
          dateTime: dateTime,
          totalAmount: totalAmount,
          carts: carts);
      orderList.add(order);

      List<Map<String, dynamic>> jsonDataList =
          orderList.map((cv) => cv.toJson()).toList();
      String jsonData = json.encode(jsonDataList);
      await prefs.setString('orderData', jsonData);
      return "Order Added";
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<OrderModel>> fetchOrderData() async {
    List<OrderModel> orderList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('orderData');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();

        orderList = decodedData.map((e) => OrderModel.fromJson(e)).toList();
      } catch (e) {
        print("error ${e}");
      }
      return orderList;
      // return dataList;
    } else {
      return orderList = [];
    }
  }
}
