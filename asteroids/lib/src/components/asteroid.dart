import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import '../asteroids.dart';
import '../config.dart' as game_settings;
import '../components/components.dart';

enum AsteroidType {asteroidO, asteroidS, asteroidX} 
enum AsteroidSize {small, medium, large} 

class Asteroid extends PositionComponent 
  with CollisionCallbacks, HasGameReference<Asteroids> {

  // Rendering
  var _graphicPath = Path();
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  Asteroid({
    required this.objType,
    required this.objSize,
    required this.velocity,
    required super.position,
    required super.angle,
  }) : super(
      anchor: Anchor.center,
      children: [CircleHitbox(isSolid: true)]
    ) {
      super.size = mapAsteroidSize();
      _points = mapAsteroidValue();
      _graphicPath = completePath();
  }

  // Core settings
  AsteroidSize objSize;
  AsteroidType objType;

  // value when destroyed
  int _points = 0;

  // Movement
  final double velocity;

  // for collisions (when shot)
  List<Asteroid> _asteroidChildren = [];


  // TODO: should depend on if we're using desktop or not
  Vector2 mapAsteroidSize() {

    switch (objSize) {
      case AsteroidSize.large:
        return Vector2(game_settings.largeAsteroidDesktop,
                       game_settings.largeAsteroidDesktop);
      case AsteroidSize.medium:
        return Vector2(game_settings.mediumAsteroidDesktop,
                       game_settings.mediumAsteroidDesktop);
      case AsteroidSize.small:
        return Vector2(game_settings.smallAsteroidDesktop,
                       game_settings.smallAsteroidDesktop);
      default:
        debugPrint("Asteroid size unset!");
        return Vector2(0, 0);
    } 
  }

  int mapAsteroidValue() {
    switch (objSize) {
      case AsteroidSize.large:
        return game_settings.largeAsteroidPoints; 
      case AsteroidSize.medium:
        return game_settings.mediumAsteroidPoints; 
      case AsteroidSize.small:
        return game_settings.smallAsteroidPoints; 
      default:
        debugPrint("Asteroid points value unset!");
        return 0; 
    }
  }

  Path completePath() {

    _verticies = [];
    final graphicPath = Path();

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
        debugPrint("Asteroid type undefined!");
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
    canvas.drawPath(_graphicPath, _paint);
  }

  void moveBy(double dt) {

    final Vector2 direciton = Vector2.zero();

    double xMove = sin(angle);
    double yMove = 0 - cos(angle);

    direciton 
      ..setValues(xMove,yMove)
      ..normalize();

    final asteroidDisplacement = direciton * (velocity * dt);

    position.add(asteroidDisplacement);

    checkWraparound();
  }

  // Checks if PositionComponent should wrap around the game screen
  // (and moves it if it should)
  void checkWraparound() {
    // wrapping around the screen: horizontal
    // right
   if (position.x > (game.size.x + size.x)) {
      position.x = 0 - size.x / 2;
    } else if ((position.x + size.x) < 0) {
      position.x = game.size.x + size.x / 2;
    }

    // wrapping around the screen: vertical 
    // bottom
    if (position.y > (game.size.y + size.y)) {
      position.y = 0 - (size.y / 2);
    } else if ((position.y + size.y) < 0 ) {
      position.y = game.size.y - (size.y / 2);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    moveBy(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, 
                        PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Shot) {
      _asteroidChildren = [];
      splitAsteroid();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Shot) {
      game.world.addAll(_asteroidChildren);
      game.score += _points;
      removeFromParent();
    }
  }

  void splitAsteroid() {

    switch (objSize) {

      case AsteroidSize.large:

        // for + pi / 4
        double newXA = position.x + sin(angle + (pi / 4)) * (width / 2);
        double newYA = position.y + (0 - cos(angle + (pi / 4)) * (height / 2));
        // for - pi / 4
        double newXB = position.x + sin(angle - (pi / 4)) * (width / 2);
        double newYB = position.y + (0 - cos(angle - (pi / 4)) * (height / 2));
        
        _asteroidChildren.add( 
          Asteroid( 
            objType: objType, 
            objSize: AsteroidSize.medium,
            velocity: velocity,
            position: Vector2(newXA, newYA),
            angle: angle
          )
        );

        _asteroidChildren.add( 
          Asteroid( 
            objType: objType, 
            objSize: AsteroidSize.medium,
            velocity: velocity,
            position: Vector2(newXB, newYB),
            angle: angle - (pi / 4)
          )
        );

      break;

      case AsteroidSize.medium:

        // for + pi / 4
        double newXA = position.x + sin(angle + (pi / 4)) * (width / 2);
        double newYA = position.y + (0 - cos(angle + (pi / 4)) * (height / 2));
        // for - pi / 4
        double newXB = position.x + sin(angle - (pi / 4)) * (width / 2);
        double newYB = position.y + (0 - cos(angle - (pi / 4)) * (height / 2));
        
        _asteroidChildren.add( 
          Asteroid( 
            objType: objType, 
            objSize: AsteroidSize.small,
            velocity: velocity,
            position: Vector2(newXA, newYA),
            angle: angle
          )
        );

        _asteroidChildren.add( 
          Asteroid( 
            objType: objType, 
            objSize: AsteroidSize.small,
            velocity: velocity,
            position: Vector2(newXB, newYB),
            angle: angle - (pi / 4)
          )
        );

      break;

      case AsteroidSize.small:
        // set to black briefly before removing entirely at collision end
        _paint.color = Colors.black;
      break;

      default:
        debugPrint("Child asteroid size unset!");
    }
  }
}
