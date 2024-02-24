// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

// general flutter packages
import 'package:flutter/material.dart';

// custom game componenets
import '../asteroids.dart';
import '../components/components.dart';

// TODO: 1. set points value
// TODO: 2. set movement behaviors (sine wave?)
// TODO: 3. scale with mobile
// TODO: 4. may need to create alien shot class as well?
class Alien extends PositionComponent 
  with CollisionCallbacks, HasPaint, HasGameReference<Asteroids> {

  // value when destroyed
  int _points = 0;

  // For rendering
  var _graphicPath = Path();
  List<List<double>> _verticies = [];

  Alien({ 
    required super.key,
    required super.size,
    required super.position,
  }) : super( 
    anchor: Anchor.center,
    children: [RectangleHitbox(isSolid: true)]
  ){ 

    // vector path
    _graphicPath = completePath();

    // define and set paint
    setPaint(
      0, 
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = Colors.white);
    paint = getPaint(0);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, 
                        PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Shot) {
      game.score += _points;
      removeFromParent();
    }
  }

  @override void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPath(_graphicPath, paint);
  }

  Path completePath() {

    _verticies = [];

    final graphicPath = Path();

    // A
    _verticies.add([(15/24) * width, (0/20) * height]);
    // B
    _verticies.add([(16/24) * width, (6/20) * height]);
    // C
    _verticies.add([(22/24) * width, (11/20) * height]);
    // D
    _verticies.add([(24/24) * width, (11/20) * height]);
    // E
    _verticies.add([(24/24) * width, (17/20) * height]);
    // F
    _verticies.add([(22/24) * width, (17/20) * height]);
    // G
    _verticies.add([(16/24) * width, (20/20) * height]);
    // H
    _verticies.add([(8/24) * width, (20/20) * height]);
    // I
    _verticies.add([(2/24) * width, (17/20) * height]);
    // J
    _verticies.add([(0/24) * width, (17/20) * height]);
    // K
    _verticies.add([(0/24) * width, (11/20) * height]);
    // L
    _verticies.add([(2/24) * width, (11/20) * height]);
    // M
    _verticies.add([(8/24) * width, (6/20) * height]);
    // N
    _verticies.add([(9/24) * width, (0/20) * height]);

    // extra path definitions
    // M -> B
    graphicPath.moveTo(_verticies[12][0], _verticies[12][1]);
    graphicPath.lineTo(_verticies[1][0], _verticies[1][1]);
    // L -> C
    graphicPath.moveTo(_verticies[11][0], _verticies[11][1]);
    graphicPath.lineTo(_verticies[2][0], _verticies[2][1]);
    // I -> F
    graphicPath.moveTo(_verticies[8][0], _verticies[8][1]);
    graphicPath.lineTo(_verticies[5][0], _verticies[5][1]);

    graphicPath.moveTo(_verticies[0][0], _verticies[0][1]);
    for(int v = 1; v < _verticies.length; v++) {
      graphicPath.lineTo(_verticies[v][0], _verticies[v][1]);
    }
    graphicPath.lineTo(_verticies[0][0], _verticies[0][1]);

    return graphicPath;

  }
}
