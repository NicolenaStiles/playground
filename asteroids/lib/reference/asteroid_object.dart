// Class for bodies that move on the asteroid field
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum AsteroidObjectType {testSquare, playerShip, asteroidX, asteroidS, asteroidO, alienShip, shot} 

class AsteroidObject extends PositionComponent with CollisionCallbacks, HasGameRef {

  List<List<double>> _verticies = [];
  AsteroidObjectType objType;

  // Define a paint object
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  @override
  AsteroidObject(this.objType);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is AsteroidObject && objType == AsteroidObjectType.asteroidO) {
      if(other.objType == AsteroidObjectType.shot) {
        _paint.color = Colors.red;
        print("${position.x}");
        print("${position.y}");
        print("$x,$y");
        print(absolutePositionOfAnchor(anchor));
        game.add(
          AsteroidObject(AsteroidObjectType.asteroidS)
          ..position = Vector2(position.x, position.y)
          ..width = width / 2
          ..height = height / 2
          ..anchor = Anchor.center
        );
        /*
        for (int i = 0; i < 2; i++) {
          addToParent(
            AsteroidObject(AsteroidObjectType.asteroidO)
            ..position = Vector2(position.x, position.y)
            ..width = width / 2
            ..height = height / 2
            ..anchor = Anchor.center
          );
        }
        */
        other.position = Vector2(-1000, -1000);
        other.removeFromParent();
      }
    }
  }

  
  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is AsteroidObject && objType == AsteroidObjectType.asteroidO) {
      if(other.objType == AsteroidObjectType.shot) {
        print(children);
        _paint.color = Colors.white;
        removeFromParent();
      }
    }
  }

  Path completePath() {

    _verticies = [];

    final graphicPath = Path();

    switch (objType) {

      case AsteroidObjectType.testSquare:

        double offset = width / 2; 

        // A
        _verticies.add([0 + offset, 0 - offset]);
        // B
        _verticies.add([0 + offset, 0 + offset]);
        // C
        _verticies.add([0 - offset, 0 + offset]);
        // D
        _verticies.add([0 - offset, 0 - offset]);

        break;

      case AsteroidObjectType.playerShip:

        // A
        _verticies.add([ width * 0.5, 0]);
        //print(_verticies[0]);
        // B
        _verticies.add([ width, height]);
        //print(_verticies[1]);
        // C
        _verticies.add([ (width * 0.8), (height * 0.8) ]);
        //print(_verticies[2]);
        // D
        _verticies.add([ (width * 0.2), (height * 0.8) ]);
        //print(_verticies[3]);
        // E
        _verticies.add([ 0 , height]);
        //print(_verticies[4]);

        break;

      case AsteroidObjectType.asteroidX:

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

      case AsteroidObjectType.asteroidS:

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

      case AsteroidObjectType.asteroidO:

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

      case AsteroidObjectType.alienShip:

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

        break;

      case AsteroidObjectType.shot: 
        graphicPath.addOval(size.toRect());
        return graphicPath;

      default:
    }

    graphicPath.moveTo(_verticies[0][0], _verticies[0][1]);
    for(int v = 1; v < _verticies.length; v++) {
      graphicPath.lineTo(_verticies[v][0], _verticies[v][1]);
    }
    graphicPath.lineTo(_verticies[0][0], _verticies[0][1]);

    return graphicPath;

  }


  @override void render(Canvas canvas) {
    canvas.drawPath(completePath(), _paint);
    //canvas.drawRect(size.toRect(), _paint);
  }

}
