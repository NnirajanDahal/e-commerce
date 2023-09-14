import 'dart:math';

import 'package:ecommerce_app/cart/bloc/carton_bloc.dart';
import 'package:ecommerce_app/cubit/slider_cubit_cubit.dart';
import 'package:ecommerce_app/products/bloc/products_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductsBloc productsBloc = ProductsBloc();
  int quantity = 1;
  int generateRandomId() {
    Random random = Random();
    return random.nextInt(999);
  }

  SliderCubitCubit sliderCubit = SliderCubitCubit();
  Container ImageSlider(String imageUrl) {
    return Container(
      width: 390,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: NetworkImage(imageUrl), fit: BoxFit.cover)),
    );
  }

  @override
  void initState() {
    productsBloc.add(ProductDetailFetchEvent(productId: widget.productId));
    sliderCubit = SliderCubitCubit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: productsBloc,
        listenWhen: (previous, current) => current is ProductActionState,
        buildWhen: (previous, current) => current is! ProductActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductsFetchingLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ProductDetailFetchingSuccessState:
              final successState = state as ProductDetailFetchingSuccessState;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 290,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        child: Image(
                          image: NetworkImage(successState.product.thumbnail),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            successState.product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " Rs.${successState.product.price}, ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 206, 133, 24)),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  successState.product.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Images",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            height: 300,
                            child: PageView.builder(
                              onPageChanged: sliderCubit.changePage,
                              itemBuilder: (context, index) {
                                var imageUrl =
                                    successState.product.images[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ImageSlider(imageUrl),
                                );
                              },
                              itemCount: successState.product.images.length,
                            ),
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity != 1) {
                                          quantity = quantity - 1;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    child: Icon(Icons.minimize)),
                                SizedBox(
                                  width: 13.0,
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 13.0,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity = quantity + 1;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    child: Icon(Icons.add))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: SizedBox(
                              width: 240,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  int cartId = generateRandomId();
                                  int productTotalAmount =
                                      quantity * successState.product.price;
                                  context.read<CartonBloc>().add(
                                      CartonDataStoreEvent(
                                          cartId,
                                          successState.product.title,
                                          successState.product.price,
                                          quantity,
                                          productTotalAmount,
                                          successState.product.thumbnail));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Added To Cart"),
                                    backgroundColor: Colors.green,
                                  ));
                                },
                                icon: Icon(Icons.trolley),
                                label: Text("Add to Cart"),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        Color.fromARGB(255, 63, 66, 73)),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
