import 'package:ecommerce_app/cart/model/cart_model.dart';
import 'package:ecommerce_app/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    context.read<OrderBloc>().add(OrderFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case OrderFetchLoadingState:
            return CircularProgressIndicator();
          case OrderFetchSuccessState:
            final successState = state as OrderFetchSuccessState;
            return successState.orderList.isEmpty
                ? Center(
                    child: Text("Your order history will display here"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "My Order History",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            reverse: true,
                            itemCount: successState.orderList.length,
                            itemBuilder: (context, index) {
                              final order = successState.orderList[index];
                              return Container(
                                color: const Color.fromARGB(255, 243, 243, 243),
                                child: Column(
                                  children: [
                                    Text(
                                      "Order Number: ${order.orderId}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      order.dateTime,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: order.carts.length,
                                        itemBuilder: (context, index) {
                                          CartModel cart = order.carts[index];
                                          return Container(
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          cart.productThumbnail,
                                                          height: 80.0,
                                                          width: 120.0,
                                                          fit: BoxFit.cover,
                                                        )),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            cart.productTitle,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            "Price: ${cart.productPrice}",
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                              'Quantity: ${cart.productQuantity}'),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                              'Total: Rs. ${cart.productTotalAmount}'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Order Total Amount: Rs. ${order.totalAmount}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      thickness: 7,
                                      color: Color.fromARGB(255, 201, 200, 200),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  );
          default:
            return Center(child: Text("No  Data"));
        }
      },
    );
  }
}
