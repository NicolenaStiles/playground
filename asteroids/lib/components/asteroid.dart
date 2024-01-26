// basic component imports
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
// for messing directly with the canvas
import 'package:flutter/material.dart';
// managing collisions
import 'shot.dart';
import 'dart:math';
import 'package:asteroids/asteroids.dart';

enum AsteroidType {asteroidX, asteroidS, asteroidO} 
enum AsteroidSize {small, medium, large} 

// TODO: make these asteroid sizes more flexible based on screen size
class Asteroid extends PositionComponent with CollisionCallbacks, HasGameRef<Asteroids> {

  // Defining the look and size of the asteroid
  AsteroidType objType;
  AsteroidSize objSize;
  int _points = 0;
  
  // For rendering
  var graphicPath = Path();
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  // for collisions (when shot)
  List<Asteroid> _asteroidChildren = [];

  // TODO: make size defaults generic
  @override
  Asteroid(this.objType, this.objSize) {
    switch (objSize) {
      case AsteroidSize.large:
        width = 128;
        height = 128;
        _points = 200;
      break;
      case AsteroidSize.medium:
        width = 64;
        height = 64;
        _points = 100;
      break;
      case AsteroidSize.small:
        width = 32;
        height = 32;
        _points = 50;
      break;
      default:
        //TODO: throw error for unset size?
      break;
    }

    graphicPath = completePath();
    add(RectangleHitbox(isSolid: true));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
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
      game.updateScore(_points);
      removeFromParent();
    }
  }

  @override void render(Canvas canvas) {
    canvas.drawPath(graphicPath, _paint);
  }

  // creates two new child asteroids after collision
  // TODO: what is default for native angle? 
  // Do I even need to be setting that in the first place?
  void splitAsteroid() {

    switch (objSize) {

      case AsteroidSize.large:
        // for + pi / 4
        double newX_A = position.x + sin(angle + (pi / 4)) * (width / 2);
        double newY_A = position.y + (0 - cos(angle + (pi / 4)) * (height / 2));
        // for - pi / 4
        double newX_B = position.x + sin(angle - (pi / 4)) * (width / 2);
        double newY_B = position.y + (0 - cos(angle - (pi / 4)) * (height / 2));
        
        _asteroidChildren.add( 
          Asteroid(objType, AsteroidSize.medium) 
          ..position = Vector2(newX_A, newY_A)
          ..angle = angle + (pi / 4)
          ..nativeAngle = 0
        );
        _asteroidChildren.add( 
          Asteroid(objType, AsteroidSize.medium) 
          ..position = Vector2(newX_B, newY_B)
          ..angle = angle - (pi / 4)
          ..nativeAngle = 0
        );

      break;

      case AsteroidSize.medium:
        // for + pi / 4
        double newX_A = position.x + sin(angle + (pi / 4)) * (width / 2);
        double newY_A = position.y + (0 - cos(angle + (pi / 4)) * (height / 2));
        // for - pi / 4
        double newX_B = position.x + sin(angle - (pi / 4)) * (width / 2);
        double newY_B = position.y + (0 - cos(angle - (pi / 4)) * (height / 2));

        _asteroidChildren.add( 
          Asteroid(objType, AsteroidSize.small) 
          ..position = Vector2(newX_A, newY_A)
          ..angle = angle + (pi / 4)
          ..nativeAngle = 0
        );
        _asteroidChildren.add( 
          Asteroid(objType, AsteroidSize.small) 
          ..position = Vector2(newX_B, newY_B)
          ..angle = angle - (pi / 4)
          ..nativeAngle = 0
        );

      break;

      case AsteroidSize.small:
        // set to black briefly before removing entirely at collision end
        _paint.color = Colors.black;
      break;

      default:
        // TODO: throw error for undefined asteroid size?

    }

  }

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

}
