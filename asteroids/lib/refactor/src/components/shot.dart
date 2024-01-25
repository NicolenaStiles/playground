import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart' as game_settings;
import '../components/components.dart';

class Shot extends CircleComponent 
  with CollisionCallbacks {

  Shot({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()],
 );

  int _timer = 0;
  final Vector2 velocity;
  int _currShotCooldown = 0;
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

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }
}

