import 'package:flutter/material.dart';
import 'package:flutter_test_aplication/provider/character_provider.dart';
import 'package:flutter_test_aplication/view/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CharacterProvider(),
      child: const MyApp(),
    ),
  );
}
