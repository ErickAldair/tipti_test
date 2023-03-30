import 'package:flutter/material.dart';

import '../model/person_model.dart';
import '../service/api_service.dart';

/// A provider class that manages the list of characters fetched from the API.
class CharacterProvider with ChangeNotifier {
  final List<Character> _characters = [];
  String _genderFilter = '';
  int _nextPage = 1;
  bool _isLoading = false;

  final ApiService _apiService;

  /// Creates a new instance of [CharacterProvider].
  ///
  /// [apiService] is an optional parameter that allows injecting a mock
  /// implementation of [ApiService] for testing purposes.
  CharacterProvider({@visibleForTesting ApiService apiService})
      : _apiService = apiService ?? ApiService();

  /// Returns the list of characters filtered by the selected gender or
  /// unfiltered if no gender is selected.
  List<Character> get characters => _genderFilter.isEmpty
      ? _characters
      : _characters.where((c) => c.gender == _genderFilter).toList();

  /// Returns whether the provider is currently fetching characters from the API.
  bool get isLoading => _isLoading;

  /// Fetches the next page of characters from the API and updates the internal list.
  ///
  /// Only one fetch operation can be in progress at a time. Subsequent calls to
  /// this method while a fetch operation is in progress will be ignored.
  void fetchCharacters() async {
    if (!_isLoading) {
      _isLoading = true;
      notifyListeners();

      List<Map<String, dynamic>> fetchedCharacters =
          await _apiService.fetchCharacters(page: _nextPage);
      _characters
          .addAll(fetchedCharacters.map((c) => Character.fromJson(c)).toList());

      _nextPage += 1;
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sets the selected gender filter and notifies listeners of the change.
  void setGenderFilter(String gender) {
    _genderFilter = gender;
    notifyListeners();
  }

  /// Returns the currently selected gender filter.
  String get genderFilter => _genderFilter;

  /// Clears the selected gender filter and notifies listeners of the change.
  void clearGenderFilter() {
    _genderFilter = '';
    notifyListeners();
  }
}
