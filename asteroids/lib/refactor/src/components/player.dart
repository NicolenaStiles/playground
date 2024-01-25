import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';
import '../config.dart' as game_settings;
import '../components/components.dart';

class Player extends PositionComponent with CollisionCallbacks, 
  HasGameRef<Asteroids> {

  Player({
    //required this.velocity,
    required super.position,
  }) : super ( 
        anchor: Anchor.center,
        size: Vector2(game_settings.playerWidthDesktop, game_settings.playerHeightDesktop),
  );

  //final Vector2 velocity;

  // Rendering
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
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


  @override
  void update(double dt) {
    super.update(dt);
  }

}
