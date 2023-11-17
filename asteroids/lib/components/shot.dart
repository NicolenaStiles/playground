import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
// for messing directly with the canvas
import 'package:flutter/material.dart';


class Shot extends PositionComponent with CollisionCallbacks {

  // For rendering
  var graphicPath = Path();
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  Shot() {
    graphicPath.addOval(size.toRect());
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

  }

  @override
  void onCollisionEnd(PositionComponent other) {

  }

  @override void render(Canvas canvas) {
    canvas.drawPath(graphicPath, _paint);
  }

}
