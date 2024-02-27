import 'package:flame/game.dart';

class GameConfig {

  // (mobile) arguments
  double screenX = 0;
  double screenY = 0;

  // basic game settings
  // these are not dependent on mobile/desktop
  int playerLives = 1;
  int largeAsteroidPoints = 200;        // points for each size of asteroid
  int mediumAsteroidPoints = 100;
  int smallAsteroidPoints = 50;
  int maxAsteroids = 10;                // max number of asteroids on screen

  // sizing configs
  // player
  double playerWidth = 36;
  double playerHeight = 60;
  // shot
  double shotRadius = 4;
  // asteroids
  double largeAsteroidSize = 128.0; 
  double mediumAsteroidSize = 64.0; 
  double smallAsteroidSize = 32.0; 
  // lives
  double livesWidth = 30;
  double livesHeight = 50;
  double livesOffset = 6;
  // alien
  double alienWidth = 64;
  double alienHeight = 40;
  // font (scoreboard)
  double fontSize = 48.0;

  // movement configs
  // player
  double playerRotationSpeed = 4; 
  Vector2 playerAcceleration = Vector2(4,4);      // untested
  int playerMaxSpeed = 400;                       // untested
  // shot
  double shotSpeed = 1024;        // how fast bullets go
  double shotTimer = 60;          // how long bullets live
  double shotCooldown = 16;       // how long until shoot bullets
  // asteroids
  static const double asteroidMinVelocity = 32;
  static const double asteroidMaxVelocity = 256;

  // mobile scalars
  static const double playerShipMobileScalar = 16;
  static const double livesMobileScalar = 24;
  static const double largeAsteroidMobileScalar = 8;
  static const double mediumAsteroidMobileScalar = 16;
  static const double smallAsteroidMobileScalar = 32;

  // Desktop constructor
  GameConfig.desktop();

  // Mobile constructor
  GameConfig.mobile(this.screenX, this.screenY) {
    // display settings
    // player height/width
    double shipHeight = (screenY / playerShipMobileScalar);
    double shipWidth = (playerWidth * shipHeight) / playerHeight;
    playerWidth = shipWidth;
    playerHeight = shipHeight;

    // lives 
    shipHeight = (screenY / livesMobileScalar);
    shipWidth = (livesWidth * shipHeight) / livesHeight;
    double shipOffset = shipWidth / 2; 
    livesWidth = shipWidth;
    livesHeight = shipHeight;
    livesOffset = shipOffset;

    // font for scoreboard
    fontSize = screenY / 16;

    // asteroids 
    double largeAsteroidMobileSize = screenX / largeAsteroidMobileScalar;
    double mediumAsteroidMobileSize = screenX / mediumAsteroidMobileScalar;
    double smallAsteroidMobileSize = screenX / smallAsteroidMobileScalar;
    largeAsteroidSize = largeAsteroidMobileSize;
    mediumAsteroidSize = mediumAsteroidMobileSize;
    smallAsteroidSize = smallAsteroidMobileSize;

    // shot 
    shotRadius = 2;

    // movement settings
    playerAcceleration.x = 2;
    playerAcceleration.y = 2;
    playerRotationSpeed = 256;

    shotSpeed = 1024;
    shotTimer = 20;
    shotCooldown = 16;
  }
}
