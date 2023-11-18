// generic imports la la la
import 'dart:math';
// flame game-related stuff
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
// Custom componenets
import 'components/asteroid.dart';
import 'package:asteroids/components/shot.dart';

class Asteroids extends FlameGame 
  with HasKeyboardHandlerComponents, HasCollisionDetection {

  // world size constants
  // TODO: window resize?
  static double worldMinX = 0;
  static double worldMinY = 0;
  static double worldMaxX = 0;
  static double worldMaxY = 0;

  // asteroid
  final Vector2 _directionAsteroid = Vector2.zero();
  static const int asteroidSpeed = 300;
  late final Asteroid testAsteroid;

  // shot
  late final Shot testShot;

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

    testAsteroid = Asteroid(AsteroidType.asteroidO, AsteroidSize.large) 
      ..position = Vector2(worldMinX,0)
      ..angle = 3 * (pi / 2)
      ..nativeAngle = 0;
    world.add(testAsteroid);

    testShot = Shot()
    ..position = Vector2(0,0)
    ..nativeAngle = 0;
    world.add(testShot);

  }

  // game loop here
  @override
  void update(double dt) {

    super.update(dt);

    // asteroids
    for (var c in world.children) {
      if (c is Asteroid) {
        double xInput = sin(c.angle);
        double yInput = (0 - cos(c.angle));

        _directionAsteroid
          ..setValues(xInput,yInput)
          ..normalize();

        final displacementAsteroid = _directionAsteroid * (asteroidSpeed * dt);
        c.position.add(displacementAsteroid);

        checkWraparound(c);
      }
    }

  }

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
