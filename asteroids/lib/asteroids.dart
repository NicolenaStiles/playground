import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import 'components/asteroid.dart';

class Asteroids extends FlameGame 
  with HasKeyboardHandlerComponents, HasCollisionDetection {

  // asteroid
  final Vector2 _directionAsteroid = Vector2.zero();
  static const int _asteroidSpeed = 300;
  late final Asteroid testAsteroid;

  @override
  Future<void> onLoad() async {

    await super.onLoad();

    testAsteroid = Asteroid(AsteroidType.asteroidO, AsteroidSize.large) 
      ..position = Vector2(size.x * 0.5, size.y * 0.25);
    add(testAsteroid);

  }

  // game loop here
  @override
  void update(double dt) {

    super.update(dt);

    _directionAsteroid
      ..setValues(0,1)
      ..normalize();

    final displacementAsteroid = _directionAsteroid * (_asteroidSpeed * dt);
    testAsteroid.position.add(displacementAsteroid);

    checkWraparound(testAsteroid);

  }

  // Checks if PositionComponent should wrap around the game screen
  // (and moves it if it should)
  void checkWraparound(PositionComponent checkObj) {
     // wrapping around the screen: horizontal
    if (checkObj.position.x > (size.x + checkObj.width)) {
      checkObj.position.x = 0 - checkObj.width / 2;
    } else if ((checkObj.position.x + checkObj.width) < 0) {
      checkObj.position.x = size.x + checkObj.width / 2;
    }
    // wrapping around the screen: vertical 
    if (checkObj.position.y > (size.y + checkObj.width)) {
      checkObj.position.y = 0 - (checkObj.height / 2);
    } else if ((checkObj.position.y + checkObj.width) < 0) {
      checkObj.position.y = size.y - (checkObj.height / 2);
    }
  }

}
