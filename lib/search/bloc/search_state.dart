part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchProductFetchingLoadingState extends SearchState {}

class SearchProductFetchingErrorState extends SearchState {
  final String error;

  SearchProductFetchingErrorState(this.error);
}

class SearchProductSuccessState extends SearchState {
  final List<ProductModel> searchProducts;

  SearchProductSuccessState(this.searchProducts);
}
