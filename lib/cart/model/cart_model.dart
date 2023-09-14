class CartModel {
  int cartId;
  int userId;
  String productTitle;
  int productPrice;
  int productQuantity;
  int productTotalAmount;
  String productThumbnail;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.productTitle,
    required this.productPrice,
    required this.productQuantity,
    required this.productTotalAmount,
    required this.productThumbnail,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartId: json["cartId"],
        userId: json["userId"],
        productTitle: json["productTitle"],
        productPrice: json["productPrice"],
        productQuantity: json["productQuantity"],
        productTotalAmount: json["productTotalAmount"],
        productThumbnail: json["productThumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "cartId": cartId,
        "userId": userId,
        "productTitle": productTitle,
        "productPrice": productPrice,
        "productQuantity": productQuantity,
        "productTotalAmount": productTotalAmount,
        "productThumbnail": productThumbnail,
      };
}
