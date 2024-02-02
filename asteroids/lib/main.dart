import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/asteroids.dart';

// TODO: 1. Create static display test image layout 
// Should include ship, all asteroid sizes, and HUD componenets

// TODO: 2. Create config file to handle independent sizing for each
// Should also go into the guts of each object and allow them to resize
// (Entirely different gameplay loop? How handle this?)

// TODO: 3. Handle resize/screen rotation (landscape vs portrait)

void main() {
  final game = Asteroids();
  runApp(GameWidget(game: game));
}
