// Class for bodies that move on the asteroid field

import 'dart:js_interop';

import 'package:flutter/material.dart';

enum AsteroidObjectType {testSquare, playerShip, smallAsteroid, mediumAsteroid, largeAsteroid, alienShip, shot} 

List<List<int>> getVerticies(int size, List<int> center, AsteroidObjectType objType) {

  List<List<int>> verticies = [[]];

  switch (objType) {
      case AsteroidObjectType.testSquare:
      break;

      default:
    }

  return verticies; 

}

class AsteroidObject {

  // properties
  int length = 0;
  int width = 0;
  List<int> center = [0,0];
  AsteroidObjectType objType;
  List<List<int>> verticies = [];

  // constructor
  AsteroidObject(this.length,this.width,this.center,this.objType) {

    // set verticies based on object type
    switch (objType) {

        case AsteroidObjectType.testSquare:

          int offset = length ~/ 2;

          // A
          verticies.add([center[0] + offset, center[1] - offset]);
          // B
          verticies.add([center[0] + offset, center[1] + offset]);
          // C
          verticies.add([center[0] - offset, center[1] + offset]);
          // D
          verticies.add([center[0] - offset, center[1] - offset]);
          
        break;

        default:
      }

    // traverse path

    
  }

  Path completePath() {

    final graphicPath = Path();

    graphicPath.moveTo(verticies[0][0].toDouble(), verticies[0][1].toDouble());
    for(int v = 1; v < verticies.length; v++) {
      graphicPath.lineTo(verticies[v][0].toDouble(), verticies[v][1].toDouble());
    }
    graphicPath.lineTo(verticies[verticies.length - 1][0].toDouble(), verticies[verticies.length - 1][1].toDouble());

    return graphicPath;
  }
}
