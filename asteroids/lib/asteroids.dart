import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'asteroid_object.dart';
import 'package:flame/input.dart';
import 'dart:math';

List<AsteroidObject> renderTestGraphics() {
  List<AsteroidObject> renderObjects = [];
  return renderObjects;
}

// TODO: better understand world vs canvas vs size
class Asteroids extends FlameGame 
  with HasKeyboardHandlerComponents, HasCollisionDetection {

  // constants
  // player
  static const int _speed = 200;
  static const int _rotationSpeed = 3;

  // shots
  static const int _shotSpeed = 600;
  int _currShotDelay = 0;
  static const int _shotDelay = 100;
  bool _shotReady = true;

  // bodies on screen @ start
  late final AsteroidObject player;
  late final AsteroidObject testAsteroid;
  late final AsteroidObject testShot;

  // direction info for bodies
  final Vector2 _direction = Vector2.zero();
  final Vector2 _directionAsteroid = Vector2.zero();
  // angle of shot?
  Vector2 _directionShot = Vector2.zero();
  double _angleShot = 0;

  final Map<LogicalKeyboardKey, double> _keyWeights = {
    LogicalKeyboardKey.keyA: 0,
    LogicalKeyboardKey.keyD: 0,
    LogicalKeyboardKey.keyW: 0,
    LogicalKeyboardKey.space: 0,
  };

  @override
  Future<void> onLoad() async {

    await super.onLoad();

    // player ship
    player = AsteroidObject(AsteroidObjectType.playerShip)
      ..position = Vector2(size.x * 0.5, size.y * 0.5)
      ..width = 36
      ..height = 60
      ..anchor = Anchor.center;

    player.add(RectangleHitbox());
    add(player);

    // test asteroid
    testAsteroid = AsteroidObject(AsteroidObjectType.asteroidS) 
      ..position = Vector2(size.x * 0.8, 0)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;

    testAsteroid.add(RectangleHitbox());
    add(testAsteroid);

    // test shot
    testShot = AsteroidObject(AsteroidObjectType.shot)
      ..position = Vector2(0,0)
      ..width = 2
      ..height = 2
      ..anchor = Anchor.center;

    // add keyboard handling to game
    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, false),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, false),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, false),
          LogicalKeyboardKey.space: (keys) =>
              _handleKey(LogicalKeyboardKey.space, false),
        },
        keyDown: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, true),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, true),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, true),
          LogicalKeyboardKey.space: (keys) =>
              _handleKey(LogicalKeyboardKey.space, true),
        },
      ),
    );
  }


  @override
  void update(double dt) {

    super.update(dt);

    // for player ship
    // rotation update
    player.angle += rInput * (_rotationSpeed * dt);
    player.angle %= 2 * pi;

    // movement update
    double xInput =  forwardMovement * sin(player.angle);
    double yInput =  forwardMovement * (0 - cos(player.angle));

    _direction
      ..setValues(xInput, yInput)
      ..normalize();

    final displacement = _direction * (_speed * dt);
    player.position.add(displacement);

    // wrapping around the screen: horizontal
    if (player.position.x > canvasSize.x) {
      player.position.x = 0;
    } else if (player.position.x < 0) {
      player.position.x = canvasSize.x;
    }

    // wrapping around the screen: vertical 
    if (player.position.y > canvasSize.y) {
      player.position.y = 0;
    } else if (player.position.y < 0) {
      player.position.y = canvasSize.y;
    }

    // for asteroid
    // position update
    _directionAsteroid
      ..setValues(0,1)
      ..normalize();

    final displacementAsteroid = _directionAsteroid * (_speed * dt);
    testAsteroid.position.add(displacementAsteroid);

    // TODO: shooting? 
    // Check if player can fire shot
    // jesus this logic sucks but whatever
    if(fireShot == 1) {
      if (_shotReady) {
        print("Shot fired!");
        // create shot object
        double shotPositionX = (player.position.x + sin(player.angle) * (player.height / 2));
        double shotPositionY = (player.position.y - cos(player.angle) * (player.height / 2));
        testShot          
          ..position = Vector2(shotPositionX,shotPositionY)
          ..width = 2
          ..height = 2
          ..anchor = Anchor.center;
        add(testShot);
        testShot.angle = player.angle;
        _shotReady = false;
      } else {
        if (_currShotDelay < _shotDelay) {
          _currShotDelay++;
        } else {
          _shotReady = true;
          _currShotDelay = 0;
          if (contains(testShot)) {
            remove(testShot);
          }
        }
      } 
    } else if (_shotReady == false) {
      if (_currShotDelay < _shotDelay) {
        _currShotDelay++;
      } else {
        _shotReady = true;
        _currShotDelay = 0;
        if(contains(testShot)) {
          remove(testShot);
        }
      }
    }

    if (contains(testShot)) {
      // movement update
      _directionShot
        ..setValues(sin(testShot.angle), 0 - cos(testShot.angle))
        ..normalize();

      final displacementShot = _directionShot * (_shotSpeed * dt);
      testShot.position.add(displacementShot);
    }

    // wrapping around the screen: horizontal
    if (testAsteroid.position.x > canvasSize.x) {
      testAsteroid.position.x = 0;
    } else if (testAsteroid.position.x < 0) {
      testAsteroid.position.x = canvasSize.x;
    }

    // wrapping around the screen: vertical 
    if (testAsteroid.position.y > canvasSize.y + testAsteroid.height) {
      testAsteroid.position.y = 0 - testAsteroid.height;
    } else if (testAsteroid.position.y < (0 - testAsteroid.height)) {
      testAsteroid.position.y = canvasSize.y + testAsteroid.height;
    }

    // TODO: collisions!
  }

  bool _handleKey(LogicalKeyboardKey key, bool isDown) {
    _keyWeights[key] = isDown ? 1 : 0;
    return true;
  }
  
  double get rInput =>
    _keyWeights[LogicalKeyboardKey.keyD]! -
    _keyWeights[LogicalKeyboardKey.keyA]!;

  double get forwardMovement =>
    _keyWeights[LogicalKeyboardKey.keyW]!;

  double get fireShot =>
    _keyWeights[LogicalKeyboardKey.space]!;

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

