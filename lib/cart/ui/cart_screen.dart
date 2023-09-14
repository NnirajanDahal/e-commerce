import 'dart:math';

import 'package:ecommerce_app/cart/bloc/carton_bloc.dart';
import 'package:ecommerce_app/cart/model/cart_model.dart';
import 'package:ecommerce_app/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int generateRandomId() {
    Random random = Random();
    return random.nextInt(999);
  }

  @override
  void initState() {
    context.read<CartonBloc>().add(CartonDataFetchEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartonBloc, CartonState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartonDataFetchingLoadingState:
            return CircularProgressIndicator();
          case CartonDataFetchSuccessState:
            final successState = state as CartonDataFetchSuccessState;
            return successState.carts.isEmpty
                ? Center(
                    child: Text("Add products to your cart"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "My Carts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            reverse: true,
                            itemCount: successState.carts.length,
                            itemBuilder: (context, index) {
                              final cart = successState.carts[index];
                              return Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              cart.productThumbnail,
                                              height: 80.0,
                                              width: 120.0,
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cart.productTitle,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
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
                                        SizedBox(
                                          width: 80,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              context.read<CartonBloc>().add(
                                                  CartonDataRemoveEvent(
                                                      cart.productTitle));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Removed From Cart"),
                                                backgroundColor: Colors.green,
                                              ));
                                            },
                                            icon: Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            ))
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                "Total Amount: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(calculateTotal(successState.carts)
                                  .toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(
                          width: 230,
                          child: ElevatedButton(
                              onPressed: () {
                                int orderId = generateRandomId();
                                String dateTime = DateTime.now().toString();
                                int totalAmount =
                                    calculateTotal(successState.carts);

                                context.read<OrderBloc>().add(OrderStoreEvent(
                                    orderId,
                                    dateTime,
                                    totalAmount,
                                    successState.carts));
                                context
                                    .read<CartonBloc>()
                                    .add(CartonDataConfirmEvent());
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Order Placed"),
                                  backgroundColor: Colors.green,
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      Color.fromARGB(255, 63, 66, 73)),
                              child: Text("Confirm Order")),
                        ),
                      ],
                    ),
                  );
          default:
            return Center(child: Text("No cart Data"));
        }
      },
    );
  }

  int calculateTotal(List<CartModel> carts) {
    int total = 0;
    for (var cart in carts) {
      total += cart.productTotalAmount;
    }
    return total;
  }
}
