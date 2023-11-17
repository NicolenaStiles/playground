import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import 'components/asteroid.dart';

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
  static const int _asteroidSpeed = 300;
  late final Asteroid testAsteroid;

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
      ..position = Vector2(worldMinX,0);
    world.add(testAsteroid);

  }

  // game loop here
  @override
  void update(double dt) {

    super.update(dt);


    // asteroid 1
    _directionAsteroid
      ..setValues(1,0)
      ..normalize();

    final displacementAsteroid = _directionAsteroid * (_asteroidSpeed * dt);
    testAsteroid.position.add(displacementAsteroid);

    checkWraparound(testAsteroid);

    // test shot

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

}
