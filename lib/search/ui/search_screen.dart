import 'package:ecommerce_app/products/ui/product_detail_page.dart';
import 'package:ecommerce_app/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    String querySearch = (query.isEmpty) ? "" : query.toLowerCase();
    if (querySearch != "") {
      context
          .read<SearchBloc>()
          .add(SearchProductFetchEvent(searchQuery: querySearch));
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchProductFetchingLoadingState:
            return Center(child: CircularProgressIndicator());
          case SearchProductFetchingErrorState:
            final errorState = state as SearchProductFetchingErrorState;
            return Center(
              child: Text(errorState.error),
            );
          case SearchProductSuccessState:
            final successState = state as SearchProductSuccessState;
            return ListView.builder(
                padding: EdgeInsets.only(top: 20),
                shrinkWrap: true,
                itemCount: successState.searchProducts.length,
                itemBuilder: (context, index) {
                  final searchProduct = successState.searchProducts[index];
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchProduct.products.length,
                      itemBuilder: (context, index) {
                        final searchProd = searchProduct.products[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ProductDetailPage(
                                          productId: searchProd.id))));
                            },
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(searchProd.thumbnail),
                            ),
                            title: Text(searchProd.title),
                            subtitle: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      });
                });
          default:
            return Center(child: const Text("Enter Product Name"));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String querySearch = (query.isEmpty) ? "" : query.toLowerCase();
    if (querySearch != "") {
      context
          .read<SearchBloc>()
          .add(SearchProductFetchEvent(searchQuery: querySearch));
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchProductFetchingLoadingState:
            return Center(child: CircularProgressIndicator());
          case SearchProductFetchingErrorState:
            final errorState = state as SearchProductFetchingErrorState;
            return Center(
              child: Text(errorState.error),
            );
          case SearchProductSuccessState:
            final successState = state as SearchProductSuccessState;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: successState.searchProducts.length,
                itemBuilder: (context, index) {
                  final searchProduct = successState.searchProducts[index];
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchProduct.products.length,
                      itemBuilder: (context, index) {
                        final searchProd = searchProduct.products[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ProductDetailPage(
                                          productId: searchProd.id))));
                            },
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(searchProd.thumbnail),
                            ),
                            title: Text(searchProd.title),
                            subtitle: Divider(
                              thickness: 1,
                              color: const Color.fromARGB(255, 206, 205, 205),
                            ),
                          ),
                        );
                      });
                });
          default:
            return Center(child: const Text("Enter Product Name"));
        }
      },
    );
  }
}
