import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchQueryNotifier extends StateNotifier<String> {
  SearchQueryNotifier() : super('');

  void changeSearchQuery(String searchQuery) {
    state = searchQuery;
  }
}

final searchQueryProvider = StateNotifierProvider<SearchQueryNotifier, String>(
    (ref) => SearchQueryNotifier());
