import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
// for messing directly with the canvas
import 'package:flutter/material.dart';


class Shot extends PositionComponent with CollisionCallbacks {

  Shot() {
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

  }

  @override
  void onCollisionEnd(PositionComponent other) {

  }

  @override void render(Canvas canvas) {

  }
}
