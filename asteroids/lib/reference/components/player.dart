import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
// for messing directly with the canvas
import 'package:flutter/material.dart';
// managing collisions
import '../asteroids.dart';
import 'shot.dart';
import 'asteroid.dart';
import 'alien.dart';

class Player extends PositionComponent with CollisionCallbacks, HasGameRef<Asteroids> {

  // NOTE: DEBUG ONLY
  bool _godmode = false;

  // Define a paint object
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  Player({super.key}){
    width = 36;
    height = 60;
    anchor = Anchor.center;
    angle = 0;
    nativeAngle = 0;
    add(RectangleHitbox(isSolid: true));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // if not invincible
    // start animation?

  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (!_godmode) {
      gameRef.updateLives();
      position = Vector2(0, 0);
    }

    // remove from world
    // remove a life
    // respawn at 0,0 if not dead
  }

  @override void render(Canvas canvas) {
    canvas.drawPath(completePath(), _paint);
  }

  // NOTE: 
  // this is its own funtion because you need to be SURE you want it
  // I really don't want this accidentally getting into production code lol
  // not sure this is the best way to do this anyway? idk
  void setGodmode(bool godmode) => _godmode = godmode;
  
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
