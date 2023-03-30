import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_aplication/provider/character_provider.dart';
import 'package:flutter_test_aplication/service/api_service.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('CharacterProvider tests', () {
    CharacterProvider characterProvider;
    MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      characterProvider = CharacterProvider(apiService: mockApiService);
    });

    test('fetchCharacters should populate characters list', () async {
      final List<Map<String, dynamic>> fetchedCharacters = [
        {'name': 'Luke Skywalker', 'gender': 'male', 'films': []},
        {'name': 'Leia Organa', 'gender': 'female', 'films': []},
      ];
      when(() => mockApiService.fetchCharacters(page: 1))
          .thenAnswer((_) async => fetchedCharacters);

      characterProvider.fetchCharacters();

      // assert
      expect(characterProvider.characters.length, 2);
      expect(characterProvider.characters[0].name, 'Luke Skywalker');
      expect(characterProvider.characters[1].name, 'Leia Organa');
      expect(characterProvider.isLoading, false);
    });

    test('setGenderFilter should update genderFilter', () {
      // act
      characterProvider.setGenderFilter('male');

      // assert
      expect(characterProvider.characters.length, 0);
      expect(characterProvider.isLoading, false);
      expect(characterProvider.genderFilter, 'male');
    });

    test('clearGenderFilter should clear genderFilter', () {
      // arrange
      characterProvider.setGenderFilter('male');

      // act
      characterProvider.clearGenderFilter();

      // assert
      expect(characterProvider.characters.length, 0);
      expect(characterProvider.isLoading, false);
      expect(characterProvider.genderFilter, '');
    });
  });
}
