import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/patient_services.dart';

class SearchResultsNotifier
    extends StateNotifier<Future<List<Map<String, dynamic>>>> {
  SearchResultsNotifier() : super(dbGetSearchResults(''));

  void newSearchResults(String searchQuery) {
    state = dbGetSearchResults(searchQuery);
  }
}

final searchResultsProvider = StateNotifierProvider<SearchResultsNotifier,
    Future<List<Map<String, dynamic>>>>((ref) => SearchResultsNotifier());
