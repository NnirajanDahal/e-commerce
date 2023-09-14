import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/products/models/product_data_model.dart';
import 'package:ecommerce_app/search/repos/search_repo.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
    on<SearchProductFetchEvent>((event, emit) async {
      try {
        emit(SearchProductFetchingLoadingState());
        List<ProductModel> searchProducts =
            await SearchRepo.fetchProducts(event.searchQuery);
        if (searchProducts.isEmpty) {
          emit(SearchProductFetchingErrorState("Not Found"));
        } else {
          emit(SearchProductSuccessState(searchProducts));
        }
      } catch (e) {
        emit(SearchProductFetchingErrorState("Not Found"));
      }
    });
  }
}
