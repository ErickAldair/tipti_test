import 'package:flutter/material.dart';

/// A class representing a Star Wars character.
class Character {
  /// The name of the character.
  final String name;

  /// The list of films the character appears in.
  final List<String> films;

  /// The gender of the character.
  final String gender;

  /// Creates a new [Character] instance.
  ///
  /// The [name], [films], and [gender] parameters must not be null.
  Character({
    @required this.name,
    @required this.films,
    @required this.gender,
  });

  /// Creates a new [Character] instance from a JSON [Map].
  ///
  /// The JSON map must have the following keys: "name", "films", and "gender".
  /// The "films" value must be a list of strings.
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      films: List<String>.from(json['films']),
      gender: json['gender'],
    );
  }
}
