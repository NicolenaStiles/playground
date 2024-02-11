import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import '../asteroids.dart';
import '../config.dart' as game_settings;
import '../components/components.dart';

class Shot extends CircleComponent 
  with CollisionCallbacks, HasGameRef<Asteroids> {

  Shot({
    required super.position,
    required super.angle,
  }) : super(
    radius: game_settings.shotRadiusDesktop,
    anchor: Anchor.center,
    paint: Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill,
    children: [CircleHitbox(radius: game_settings.shotRadiusDesktop)],
  );

  int _timer = 0;

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, 
    PositionComponent other) {

    super.onCollisionStart(intersectionPoints, other);

    if (other is Asteroid) { 
      removeFromParent();
    }
  }

  void moveBy(double dt) {

    final Vector2 direciton = Vector2.zero();

    double xMove = sin(angle);
    double yMove = 0 - cos(angle);

    direciton 
      ..setValues(xMove,yMove)
      ..normalize();

    final shotDisplacement = direciton * (game_settings.shotSpeed * dt);

    position.add(shotDisplacement);

    checkWraparound();
  }

  // Checks if PositionComponent should wrap around the game screen
  // (and moves it if it should)
  void checkWraparound() {
    // wrapping around the screen: horizontal
    // right
   if (position.x > (game.size.x + size.x)) {
      position.x = 0 - size.x / 2;
    } else if ((position.x + size.x) < 0) {
      position.x = game.size.x + size.x / 2;
    }

    // wrapping around the screen: vertical 
    // bottom
    if (position.y > (game.size.y + size.y)) {
      position.y = 0 - (size.y / 2);
    } else if ((position.y + size.y) < 0 ) {
      position.y = game.size.y - (size.y / 2);
    }
  }


  @override
  void update(double dt) {
    super.update(dt);

    if (_timer < game_settings.shotTimer) {
      moveBy(dt);
      _timer++;
    } else {
      removeFromParent();
    }

  }
}

