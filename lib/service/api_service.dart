import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// This class provides API service to fetch Star Wars character data.
class ApiService {
  /// Base URL for the Star Wars API.
  static const String apiUrl = 'https://swapi.dev/api/';

  /// HTTP client to make requests.
  final http.Client _httpClient;

  /// Constructs a new instance of the [ApiService] with the given [httpClient].
  ApiService({@visibleForTesting http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Fetches a list of Star Wars characters from the API.
  ///
  /// The [page] parameter specifies the page of results to fetch. Defaults to 1.
  /// Returns a list of JSON data as a [Future].
  /// Throws an [Exception] if the request fails.
  Future<List<Map<String, dynamic>>> fetchCharacters({int page = 1}) async {
    final response =
        await _httpClient.get(Uri.parse('${apiUrl}people/?page=$page'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return List.castFrom(data['results']);
    } else {
      throw Exception('Error fetching characters');
    }
  }
}
