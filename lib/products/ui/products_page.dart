import 'package:ecommerce_app/products/bloc/products_bloc.dart';
import 'package:ecommerce_app/products/ui/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsBloc productsBloc = ProductsBloc();
  @override
  void initState() {
    productsBloc.add(ProductsInitialFetchEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
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
          case ProductsFetchingSuccessfulState:
            final successState = state as ProductsFetchingSuccessfulState;
            return SingleChildScrollView(
              child: Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.all(19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "Products",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 228, 227, 227),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            Text("Search Products")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: successState.products.length,
                        itemBuilder: (context, index) {
                          final product = successState.products[index];
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 220,
                            ),
                            itemCount: product.products.length,
                            itemBuilder: (context, index) {
                              final prod = product.products[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              ProductDetailPage(
                                                  productId: prod.id))));
                                },
                                child: Container(
                                  height: 400,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0)),
                                        child: Image.network(
                                          prod.thumbnail,
                                          width: double.infinity,
                                          height: 110,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        prod.title,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "Rs. ${prod.price}",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
