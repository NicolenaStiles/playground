import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'asteroid_object.dart';
import 'package:flame/input.dart';

List<AsteroidObject> renderTestGraphics() {
  List<AsteroidObject> renderObjects = [];
  return renderObjects;
}

class Asteroids extends FlameGame with HasKeyboardHandlerComponents {

  static const int _speed = 200;

  late final AsteroidObject player;

  final Vector2 _direction = Vector2.zero();

  final Map<LogicalKeyboardKey, double> _keyWeights = {
    LogicalKeyboardKey.keyW: 0,
    LogicalKeyboardKey.keyA: 0,
    LogicalKeyboardKey.keyS: 0,
    LogicalKeyboardKey.keyD: 0,
  };

  @override
  Future<void> onLoad() async {

    await super.onLoad();
    print("Viewport: ${size.x},${size.y}");
    print("Canvas: ${canvasSize.x},${canvasSize.y}");
    print(camera.visibleWorldRect);

    // player ship
    player = AsteroidObject(AsteroidObjectType.playerShip)
      ..position = Vector2(size.x * 0.2, size.y * 0.25)
      ..width = 36
      ..height = 60
      ..anchor = Anchor.center;

    add(player);

    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, false),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, false),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, false),
          LogicalKeyboardKey.keyS: (keys) =>
              _handleKey(LogicalKeyboardKey.keyS, false),
        },
        keyDown: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, true),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, true),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, true),
          LogicalKeyboardKey.keyS: (keys) =>
              _handleKey(LogicalKeyboardKey.keyS, true),
        },
      ),
    );
  }

  @override
    void update(double dt) {
      super.update(dt);

      _direction
        ..setValues(xInput, yInput)
        ..normalize();

      final displacement = _direction * (_speed * dt);
      player.position.add(displacement);
    }

  bool _handleKey(LogicalKeyboardKey key, bool isDown) {
    _keyWeights[key] = isDown ? 1 : 0;
    return true;
  }

  double get xInput =>
    _keyWeights[LogicalKeyboardKey.keyD]! -
    _keyWeights[LogicalKeyboardKey.keyA]!;

  double get yInput =>
    _keyWeights[LogicalKeyboardKey.keyS]! -
    _keyWeights[LogicalKeyboardKey.keyW]!;


  void renderTestGraphics() {

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

