import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_aplication/model/person_model.dart';
import 'package:flutter_test_aplication/view/home_page.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test_aplication/provider/character_provider.dart';
import 'package:provider/provider.dart';

class MockCharacterProvider extends Mock implements CharacterProvider {}

void main() {
  MockCharacterProvider characterProvider;

  setUp(() {
    characterProvider = MockCharacterProvider();
  });

  group('CharacterScreen widget', () {
    testWidgets('displays loading spinner when characters are loading',
        (WidgetTester tester) async {
      when(() => characterProvider.characters).thenReturn([]);
      when(() => characterProvider.isLoading).thenReturn(true);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CharacterProvider>.value(
            value: characterProvider,
            child: const CharacterScreen(),
          ),
        ),
      );

      expect(find.byType(SpinKitCircle), findsOneWidget);
    });

    testWidgets(
        'displays "No hay personajes disponibles" when there are no characters',
        (WidgetTester tester) async {
      when(() => characterProvider.characters).thenReturn([]);
      when(() => characterProvider.isLoading).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CharacterProvider>.value(
            value: characterProvider,
            child: const CharacterScreen(),
          ),
        ),
      );

      expect(find.text('No hay personajes disponibles'), findsOneWidget);
    });

    testWidgets('displays characters when there are characters',
        (WidgetTester tester) async {
      final characters = List.generate(
        5,
        (index) => Character(
          name: 'Personaje $index',
          gender: 'male',
          films: [
            'A New Hope',
            'The Empire Strikes Back',
            'Return of the Jedi'
          ],
        ),
      );
      when(() => characterProvider.characters).thenReturn(characters);
      when(() => characterProvider.isLoading).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CharacterProvider>.value(
            value: characterProvider,
            child: const CharacterScreen(),
          ),
        ),
      );

      expect(find.byType(CustomScrollView), findsOneWidget);
      await tester.scrollUntilVisible(find.byType(ListTile).last, 300,
          scrollable: find.byType(Scrollable).first);
      expect(find.byType(ListTile), findsNWidgets(5));
    });
  });
}
