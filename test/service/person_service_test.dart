import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_aplication/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    ApiService apiService;
    MockHttpClient mockClient;

    setUp(() {
      mockClient = MockHttpClient();
      apiService = ApiService(httpClient: mockClient);
    });

    test('fetchCharacters returns list of character maps', () async {
      final mockResponse = http.Response(
          jsonEncode({
            'results': [
              {'name': 'Luke Skywalker', 'gender': 'male'},
              {'name': 'Leia Organa', 'gender': 'female'},
            ]
          }),
          200);
      when(() =>
              mockClient.get(Uri.parse('https://swapi.dev/api/people/?page=1')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.fetchCharacters(page: 1);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result, hasLength(2));
      expect(result[0], containsPair('name', 'Luke Skywalker'));
      expect(result[0], containsPair('gender', 'male'));
      expect(result[1], containsPair('name', 'Leia Organa'));
      expect(result[1], containsPair('gender', 'female'));
    });

    test('fetchCharacters throws exception when http call fails', () async {
      when(() =>
              mockClient.get(Uri.parse('https://swapi.dev/api/people/?page=1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.fetchCharacters(page: 1), throwsException);
    });
  });
}
