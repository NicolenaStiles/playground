import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/asteroids.dart';

void main() {
  final game = Asteroids();
  runApp(GameWidget(game: game));
}
