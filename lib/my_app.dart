import 'package:flutter/material.dart';
import 'package:flutter_test_aplication/view/character_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Characters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CharacterScreen(),
    );
  }
}
