import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import '../config.dart' as game_settings;
import '../components/components.dart';

class Shot extends CircleComponent 
  with CollisionCallbacks {

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
  //int _timeToLive;
  //bool shotReady = true;

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

    add(MoveByEffect(
      Vector2( 
        shotDisplacement[0],
        shotDisplacement[1]
      ),
      EffectController(duration: 0))
    );

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

