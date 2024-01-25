/*
// main application testing
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'asteroids.dart';

void main() => runApp(GameWidget(game: Asteroids()));
*/

// refactor testing 
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'refactor/src/asteroids.dart';

void main() {
  final game = Asteroids();
  runApp(GameWidget(game: game)); 
}
