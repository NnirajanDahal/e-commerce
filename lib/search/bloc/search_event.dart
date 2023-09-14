part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchProductFetchEvent extends SearchEvent {
  final String searchQuery;

  SearchProductFetchEvent({required this.searchQuery});
}
