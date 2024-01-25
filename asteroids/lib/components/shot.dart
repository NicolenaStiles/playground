import 'package:asteroids/components/asteroid.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
// for messing directly with the canvas
import 'package:flutter/material.dart';


class Shot extends PositionComponent with CollisionCallbacks {

  int _timer = 0;

  // For rendering
  var graphicPath = Path();
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  Shot() {
    _timer = 0;
    width = 2;
    height = 2;
    anchor = Anchor.center;

    graphicPath.addOval(size.toRect());
    add(RectangleHitbox(isSolid: true));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Asteroid) {
      removeFromParent();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {

  }

  @override void render(Canvas canvas) {
    canvas.drawPath(graphicPath, _paint);
  }

  void checkTimer(int max){
    // lol did I do this right
    _timer < max ? _timer++ : removeFromParent();
    /*
    if (_timer < max) {
      _timer++;
    } else {
      removeFromParent();
    }
    */

  }

}
