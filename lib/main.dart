import 'package:flutter/material.dart';
import 'package:flutter_test_aplication/provider/character_provider.dart';
import 'package:flutter_test_aplication/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CharacterProvider(),
      child: const MyApp(),
    ),
  );
}
