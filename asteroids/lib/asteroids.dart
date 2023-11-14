import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'asteroid_object.dart';

class Asteroids extends FlameGame {

  @override
  Future<void> onLoad() async {

    await super.onLoad();
    print("Viewport: ${size.x},${size.y}");
    print("Canvas: ${canvasSize.x},${canvasSize.y}");
    print(camera.visibleWorldRect);

    // player ship
    AsteroidObject player = AsteroidObject(AsteroidObjectType.playerShip)
      ..position = Vector2(size.x * 0.2, size.y * 0.25)
      ..width = 36
      ..height = 60
      ..anchor = Anchor.center;

    // alien ship
    AsteroidObject alien = AsteroidObject(AsteroidObjectType.alienShip)
      ..position = Vector2(size.x * 0.2, size.y * 0.5)
      ..width = 72 
      ..height = 60 
      ..anchor = Anchor.center;

    // shot 
    AsteroidObject shot = AsteroidObject(AsteroidObjectType.shot)
      ..position = Vector2(size.x * 0.2, size.y * 0.75)
      ..width = 2
      ..height = 2
      ..anchor = Anchor.center;

    // asteroid X-shape
    // small
    AsteroidObject smallX = AsteroidObject(AsteroidObjectType.asteroidX)
      ..position = Vector2(size.x * 0.4, size.y * 0.3)
      ..width = 64 
      ..height = 64 
      ..anchor = Anchor.center;
  
    // medium
    AsteroidObject medX = AsteroidObject(AsteroidObjectType.asteroidX)
      ..position = Vector2(size.x * 0.4, size.y * 0.5)
      ..width = 96
      ..height = 96
      ..anchor = Anchor.center;
    
    // large
    AsteroidObject largeX = AsteroidObject(AsteroidObjectType.asteroidX)
      ..position = Vector2(size.x * 0.4, size.y * 0.7)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;

    // asteroid S-shape
    // small
    AsteroidObject smallS = AsteroidObject(AsteroidObjectType.asteroidS)
      ..position = Vector2(size.x * 0.6, size.y * 0.3)
      ..width = 64 
      ..height = 64 
      ..anchor = Anchor.center;

    // medium
    AsteroidObject medS = AsteroidObject(AsteroidObjectType.asteroidS)
      ..position = Vector2(size.x * 0.6, size.y * 0.5)
      ..width = 96
      ..height = 96
      ..anchor = Anchor.center;
    
    // large
    AsteroidObject largeS = AsteroidObject(AsteroidObjectType.asteroidS)
      ..position = Vector2(size.x * 0.6, size.y * 0.7)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;

    // asteroid O-shape
    // small
    AsteroidObject smallO = AsteroidObject(AsteroidObjectType.asteroidO)
      ..position = Vector2(size.x * 0.8, size.y * 0.3)
      ..width = 64 
      ..height = 64 
      ..anchor = Anchor.center;

    // medium
    AsteroidObject medO = AsteroidObject(AsteroidObjectType.asteroidO)
      ..position = Vector2(size.x * 0.8, size.y * 0.5)
      ..width = 96
      ..height = 96
      ..anchor = Anchor.center;
    
    // large
    AsteroidObject largeO = AsteroidObject(AsteroidObjectType.asteroidO)
      ..position = Vector2(size.x * 0.8, size.y * 0.7)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;


    addAll([player,
    alien,
    shot,
    smallX,medX,largeX,
    smallS,medS,largeS,
    smallO,medO,largeO,
    ]);

  }
}

