import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';
import '../config.dart' as game_settings;
import '../components/components.dart';

enum AsteroidType {asteroidX, asteroidS, asteroidO} 
enum AsteroidSize {small, medium, large} 

// TODO: update asteroid hitbox logic for circular
class Asteroid extends PositionComponent 
  with CollisionCallbacks, HasGameReference<Asteroids> {

  Asteroid({
    required this.velocity,
    required this.objType,
    required this.objSize,
    required super.position,
    }) : super( 
          anchor: Anchor.center,
          //children: [CircleHitbox(radius: game_settings.largeAsteroidDesktop)],
    );

  // Defining the look and size of the asteroid
  AsteroidType objType;
  AsteroidSize objSize;

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

}
