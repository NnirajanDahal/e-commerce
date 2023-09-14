import 'package:ecommerce_app/cart/model/cart_model.dart';

class OrderModel {
  int orderId;
  String dateTime;
  int totalAmount;
  List<CartModel> carts;
  OrderModel({
    required this.orderId,
    required this.dateTime,
    required this.totalAmount,
    required this.carts,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["orderId"],
        dateTime: json["dateTime"],
        totalAmount: json["totalAmount"],
        carts: List<CartModel>.from(
          json['carts'].map((e) => CartModel.fromJson(e)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "dateTime": dateTime,
        "totalAmount": totalAmount,
        "carts": carts.map((e) => e.toJson()).toList(),
      };
}
