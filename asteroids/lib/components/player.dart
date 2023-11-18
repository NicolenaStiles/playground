import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
// for messing directly with the canvas
import 'package:flutter/material.dart';

class Player extends PositionComponent with CollisionCallbacks {

  // Define a paint object
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  Player(){
    width = 36;
    height = 60;
    anchor = Anchor.center;
    angle = 0;
    nativeAngle = 0;
    add(RectangleHitbox(isSolid: true));
  }

  //TODO: Collisions!
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

  }

  @override
  void onCollisionEnd(PositionComponent other) {

  }

  @override void render(Canvas canvas) {
    canvas.drawPath(completePath(), _paint);
  }
  
  Path completePath() {

    _verticies = [];
    final graphicPath = Path();

    // A
    _verticies.add([ width * 0.5, 0]);
    // B
    _verticies.add([ width, height]);
    // C
    _verticies.add([ (width * 0.8), (height * 0.8) ]);
    // D
    _verticies.add([ (width * 0.2), (height * 0.8) ]);
    // E
    _verticies.add([ 0 , height]);

    graphicPath.moveTo(_verticies[0][0], _verticies[0][1]);
    for(int v = 1; v < _verticies.length; v++) {
      graphicPath.lineTo(_verticies[v][0], _verticies[v][1]);
    }
    graphicPath.lineTo(_verticies[0][0], _verticies[0][1]);

    return graphicPath;

  }
  
}
