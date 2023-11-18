// generic imports la la la
import 'dart:math';
// flame game-related stuff
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
// Custom componenets
import 'components/asteroid.dart';
import 'package:asteroids/components/shot.dart';
import 'package:asteroids/components/player.dart';

class Asteroids extends FlameGame 
  with HasKeyboardHandlerComponents, HasCollisionDetection {

  // world size constants
  // TODO: window resize?
  static double worldMinX = 0;
  static double worldMinY = 0;
  static double worldMaxX = 0;
  static double worldMaxY = 0;

   // player
  static const int _playerSpeed = 200;
  static const int _rotationSpeed = 3;
  late final Player player;

  // asteroid
  static const int asteroidSpeed = 300;
  late final Asteroid testAsteroid;

  // Keyboard handler map
  final Map<LogicalKeyboardKey, double> _keyWeights = {
    LogicalKeyboardKey.keyA: 0,
    LogicalKeyboardKey.keyD: 0,
    LogicalKeyboardKey.keyW: 0,
    LogicalKeyboardKey.space: 0,
  };

  @override
  Future<void> onLoad() async {

    await super.onLoad();

    // DEBUG ONLY
    add(FpsTextComponent(position: Vector2(5, canvasSize.y - 30)));

    // TODO: find a way to get rid of warning?
    worldMinX = camera.viewfinder.visibleWorldRect.left;
    worldMinY = camera.viewfinder.visibleWorldRect.bottom;
    worldMaxX = camera.viewfinder.visibleWorldRect.right;
    worldMaxY = camera.viewfinder.visibleWorldRect.top;

    player = Player() 
    ..position = Vector2(0, 0);
    world.add(player);

    testAsteroid = Asteroid(AsteroidType.asteroidO, AsteroidSize.large) 
      ..position = Vector2(worldMinX,0)
      ..angle = 3 * (pi / 2)
      ..nativeAngle = 0;
    world.add(testAsteroid);

    startKeyboardListener();

  }

  // game loop here
  @override
  void update(double dt) {

    super.update(dt);

    for (var c in world.children) {

      if (c is Asteroid) {
        moveAsteroid(c, dt);

      } else if (c is Player) {
        movePlayer(dt);
      }
    }

  }

  // bring up KeyboardListener component
  void startKeyboardListener() {
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

  bool _handleKey(LogicalKeyboardKey key, bool isDown) {
    _keyWeights[key] = isDown ? 1 : 0;
    return true;
  }

  // rotational input: uses keys D and A
  double get rInput =>
    _keyWeights[LogicalKeyboardKey.keyD]! -
    _keyWeights[LogicalKeyboardKey.keyA]!;

  // forward movement: uses W
  double get forwardMovement =>
    _keyWeights[LogicalKeyboardKey.keyW]!;

  // fire shot: uses spacebar
  double get fireShot =>
    _keyWeights[LogicalKeyboardKey.space]!;

  // Checks if PositionComponent should wrap around the game screen
  // (and moves it if it should)
  void checkWraparound(PositionComponent checkObj) {
    // wrapping around the screen: horizontal
    // right
    if (checkObj.position.x > (worldMaxX + checkObj.width)) {
      checkObj.position.x = worldMinX - checkObj.width / 2;
    // left
    } else if ((checkObj.position.x + checkObj.width) < worldMinX) {
      checkObj.position.x = worldMaxX + checkObj.width / 2;
    }
    // wrapping around the screen: vertical 
    // bottom
    if (checkObj.position.y < (worldMaxY - checkObj.height)) {
      checkObj.position.y = worldMinY - (checkObj.height / 2);
    } else if ((checkObj.position.y - checkObj.height) > worldMinY) {
      checkObj.position.y = worldMaxY - (checkObj.height / 2);
    }
  }

  // move player's ship based on input, time slice, and speed 
  void movePlayer(double dt) {

    final Vector2 direciton = Vector2.zero();
    
    // rotation update
    player.angle += rInput * (_rotationSpeed * dt);
    player.angle %= 2 * pi;

    // movement update
    double xInput = forwardMovement * sin(player.angle);
    double yInput = forwardMovement * (0 - cos(player.angle));

    direciton 
      ..setValues(xInput, yInput)
      ..normalize();

    final displacement = direciton * (_playerSpeed * dt);
    player.position.add(displacement);

    checkWraparound(player);
  }

  // moves an asteroid object based on current angle and time slice dt
  void moveAsteroid (Asteroid rock, double dt) {

    final Vector2 direciton = Vector2.zero();

    double xInput = sin(rock.angle);
    double yInput = 0 - cos(rock.angle);

    direciton 
      ..setValues(xInput,yInput)
      ..normalize();

    final displacementAsteroid = direciton * (asteroidSpeed * dt);
    rock.position.add(displacementAsteroid);
    // TODO: might wanna remove this if I switch to something that isn't just 
    // asteroids looping until they get killed
    checkWraparound(rock);
  }

}
