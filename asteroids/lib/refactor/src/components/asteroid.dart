import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';
import '../config.dart' as game_settings;
import '../components/components.dart';

enum AsteroidType {asteroidX, asteroidS, asteroidO} 
enum AsteroidSize {small, medium, large} 

// TODO: update asteroid hitbox logic for circular
class Asteroid extends PositionComponent 
  with CollisionCallbacks, HasGameReference<Asteroids> {

  Asteroid({
    required this.objType,
    required this.objSize,
    required this.velocity,
    required super.position,
  }) : super(
      anchor: Anchor.center,
      children: [CircleHitbox()]
    ) {
    // TODO: should depend on if we're using desktop or not
    switch (objSize) {
      case AsteroidSize.large:
        super.size = Vector2(game_settings.largeAsteroidDesktop,
                             game_settings.largeAsteroidDesktop);
        break;
      case AsteroidSize.medium:
        super.size = Vector2(game_settings.mediumAsteroidDesktop,
                             game_settings.mediumAsteroidDesktop);
        break;
      case AsteroidSize.small:
        super.size = Vector2(game_settings.smallAsteroidDesktop,
                             game_settings.smallAsteroidDesktop);
        break;
      default:
        print("omg value unset?!");
    } 
  }

  AsteroidSize objSize;
  AsteroidType objType;

  final Vector2 velocity;

  // Rendering
  var graphicPath = Path();
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  Path completePath() {

    _verticies = [];

    switch (objType) {

      case AsteroidType.asteroidX:

        // A
        _verticies.add([(8/16) * width, (0/16) * height]);
        // B
        _verticies.add([(12/16) * width, (0/16) * height]);
        // C
        _verticies.add([(16/16) * width, (3/16) * height]);
        // D
        _verticies.add([(12/16) * width, (5/16) * height]);
        // E
        _verticies.add([(16/16) * width, (8/16) * height]);
        // F
        _verticies.add([(12/16) * width, (16/16) * height]);
        // G
        _verticies.add([(7/16) * width, (14/16) * height]);
        // H
        _verticies.add([(5/16) * width, (16/16) * height]);
        // I
        _verticies.add([(0/16) * width, (11/16) * height]);
        // J
        _verticies.add([(2/16) * width, (8/16) * height]);
        // K
        _verticies.add([(0/16) * width, (5/16) * height]);
        // L
        _verticies.add([(4/16) * width, (0/16) * height]);

        break;

      case AsteroidType.asteroidS:

        // A
        _verticies.add([(10/16) * width, (0/16) * height]);
        // B
        _verticies.add([(16/16) * width, (4/16) * height]);
        // C
        _verticies.add([(16/16) * width, (6/16) * height]);
        // D
        _verticies.add([(10/16) * width, (8/16) * height]);
        // E
        _verticies.add([(16/16) * width, (11/16) * height]);
        // F
        _verticies.add([(12/16) * width, (16/16) * height]);
        // G
        _verticies.add([(10/16) * width, (14/16) * height]);
        // H
        _verticies.add([(4/16) * width, (16/16) * height]);
        // I
        _verticies.add([(0/16) * width, (10/16) * height]);
        // J
        _verticies.add([(0/16) * width, (5/16) * height]);
        // K
        _verticies.add([(7/16) * width, (5/16) * height]);
        // L
        _verticies.add([(4/16) * width, (0/16) * height]);

        break;

      case AsteroidType.asteroidO:

        // A
        _verticies.add([(11/16) * width, (0/16) * height]);
        // B
        _verticies.add([(16/16) * width, (4/16) * height]);
        // C
        _verticies.add([(16/16) * width, (11/16) * height]);
        // D
        _verticies.add([(10/16) * width, (16/16) * height]);
        // E
        _verticies.add([(7/16) * width, (9/16) * height]);
        // F
        _verticies.add([(6/16) * width, (16/16) * height]);
        // G
        _verticies.add([(0/16) * width, (10/16) * height]);
        // H
        _verticies.add([(5/16) * width, (8/16) * height]);
        // I
        _verticies.add([(0/16) * width, (6/16) * height]);
        // J
        _verticies.add([(5/16) * width, (0/16) * height]);

        break;

      default:
        // TODO: throw error for undefined asteroid type
        break;

    }

    graphicPath.moveTo(_verticies[0][0], _verticies[0][1]);
    for(int v = 1; v < _verticies.length; v++) {
      graphicPath.lineTo(_verticies[v][0], _verticies[v][1]);
    }
    graphicPath.lineTo(_verticies[0][0], _verticies[0][1]);

    return graphicPath;

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPath(completePath(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

}
