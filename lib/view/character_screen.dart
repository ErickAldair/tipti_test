import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_aplication/provider/character_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

// This is the main widget that displays the list of Star Wars characters.
class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  // We use a ScrollController to detect when the user has scrolled to the bottom of the list.
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // When the widget is first initialized, we wait for the first frame to be drawn,
    // and then we call the fetchCharacters method of the CharacterProvider to load
    // the initial list of characters.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharacterProvider>().fetchCharacters();
    });
    // We add a listener to the ScrollController to detect when the user has scrolled
    // to the bottom of the list.
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // We remove the listener when the widget is disposed to avoid memory leaks.
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // This method is called when the user has scrolled to the bottom of the list.
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // We call the fetchCharacters method of the CharacterProvider to load more characters.
      context.read<CharacterProvider>().fetchCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Star Wars Characters'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                context.read<CharacterProvider>().clearGenderFilter();
              } else {
                context.read<CharacterProvider>().setGenderFilter(value);
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(
                  value: 'male',
                  child: Text('Masculino'),
                ),
                PopupMenuItem<String>(
                  value: 'female',
                  child: Text('Femenino'),
                ),
                PopupMenuItem<String>(
                  value: 'n/a',
                  child: Text('Sin datos'),
                ),
                PopupMenuItem<String>(
                  value: 'clear',
                  child: Text('Limpiar filtro'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Consumer<CharacterProvider>(
          builder: (context, characterProvider, child) {
        if (characterProvider.characters.isNotEmpty) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: _GyroscopeLogo(),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == characterProvider.characters.length) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SpinKitCircle(color: Colors.blue),
                      );
                    } else {
                      final character = characterProvider.characters[index];
                      return ListTile(
                        title: Text(character.name),
                        subtitle: Text('Películas: ${character.films.length}'),
                        trailing: Text(character.gender),
                      );
                    }
                  },
                  childCount: characterProvider.characters.length +
                      (characterProvider.isLoading ? 1 : 0),
                ),
              ),
            ],
          );
        } else if (characterProvider.isLoading) {
          return const Center(child: SpinKitCircle(color: Colors.blue));
        } else {
          return const Center(child: Text('No hay personajes disponibles'));
        }
      }),
    );
  }
}

class _GyroscopeLogo extends StatefulWidget {
  const _GyroscopeLogo({Key key}) : super(key: key);

  @override
  State<_GyroscopeLogo> createState() => _GyroscopeLogoState();
}

class _GyroscopeLogoState extends State<_GyroscopeLogo> {
  GyroscopeEvent _gyroscopeEvent;
  StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      setState(() {
        _gyroscopeEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double rotationX = _gyroscopeEvent?.x ?? 0;
    double rotationY = _gyroscopeEvent?.y ?? 0;
    return Transform(
      transform: Matrix4.rotationX(rotationX) * Matrix4.rotationY(rotationY),
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
