import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// import 'src/asteroids.dart';
import 'src/mobile_asteroids.dart';

void main() {
  final isMobile = kIsWeb && 
                  (defaultTargetPlatform == TargetPlatform.iOS || 
                   defaultTargetPlatform == TargetPlatform.android);
  // final game = Asteroids(isMobile);
  final game = MobileAsteroids(isMobile);
  runApp(GameWidget(game: game));
}
