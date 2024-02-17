import 'package:flame/game.dart';

// core gameplay settings
// lives outside of platform-related stuff
const int respawnTimer = 30; 
const int playerLives = 1;
const int largeAsteroidPoints = 200;
const int mediumAsteroidPoints = 100;
const int smallAsteroidPoints = 50;

class GameCfg {

  // (optional) arguments
  double screenX = 0;
  double screenY = 0;

  // TODO: change this into an upper and lower bound instead
  static double asteroidSpeed = 120.0;

  // shared
  double playerWidth = 36;
  double playerHeight = 60;

  double playerRotationSpeed = 4; 
  Vector2 playerAcceleration = Vector2(4,4);      // untested
  int playerMaxSpeed = 400;                       // untested

  double livesWidth = 30;
  double livesHeight = 50;
  double livesOffset = 6;

  double fontSize = 48.0;

  double largeAsteroidSize = 128.0; 
  double mediumAsteroidSize = 64.0; 
  double smallAsteroidSize = 32.0; 

  double alienWidth = 64;
  double alienHeight = 40;

  // mobile scalars
  static const double playerShipMobileScalar = 16;
  static const double livesMobileScalar = 24;
  static const double largeAsteroidMobileScalar = 8;
  static const double mediumAsteroidMobileScalar = 16;
  static const double smallAsteroidMobileScalar = 32;

  // shot
  double shotRadius = 4;
  double shotSpeed = 1024;        // how fast bullets go
  double shotTimer = 60;          // how long bullets live
  double shotCooldown = 16;       // how long until shoot bullets

  // Desktop constructor
  GameCfg.desktop();

  // Mobile constructor
  GameCfg.mobile(this.screenX, this.screenY) {
    // player height/width
    double shipHeight = (screenY / playerShipMobileScalar);
    double shipWidth = (playerWidth * shipHeight) / playerHeight;
    playerWidth = shipWidth;
    playerHeight = shipHeight;

    // lives display height/width
    shipHeight = (screenY / livesMobileScalar);
    shipWidth = (livesWidth * shipHeight) / livesHeight;
    double shipOffset = shipWidth / 2; // TODO: check if this makes any sense
    livesWidth = shipWidth;
    livesHeight = shipHeight;
    livesOffset = shipOffset;

    // font size for scoreboard
    fontSize = screenY / 16;

    // asteroids settings
    double largeAsteroidMobileSize = screenX / largeAsteroidMobileScalar;
    double mediumAsteroidMobileSize = screenX / mediumAsteroidMobileScalar;
    double smallAsteroidMobileSize = screenX / smallAsteroidMobileScalar;
    largeAsteroidSize = largeAsteroidMobileSize;
    mediumAsteroidSize = mediumAsteroidMobileSize;
    smallAsteroidSize = smallAsteroidMobileSize;

    // shot settings
    shotRadius = 2;
    shotSpeed = 1024;
    shotTimer = 20;
    shotCooldown = 16;

  }
}

// TODO: change this into an upper and lower bound instead
double asteroidSpeed = 120.0;

double livesWidth = 30;
double livesHeight = 42;
double livesOffset = 8;

// mobile scalars
double playerShipMobileScalar = 16;
Vector2 mobilePlayerAcceleration = Vector2(2,2);

// mobile rotation settings
const double mobilePlayerRotatationSpeed = 256; // in degrees I think?

// player settings
double playerRotationSpeed = 4; 
Vector2 playerAcceleration = Vector2(4,4);      // untested
int playerMaxSpeed = 400;                       // untested

// shot
const double shotRadiusDesktop = 4;
const double shotSpeed = 1024;        // how fast bullets go
const double shotTimer = 60;          // how long bullets live
const double shotCooldown = 16;       // how long until shoot bullets

// alien
// WARN : I pulled these numbers out of my ass
const alienWidthDesktop = 60;
const alienHeightDesktop = 36;

// I'm doing powers of 2 here
// only tested on desktop
const double asteroidMinVelocity = 32;
const double asteroidMaxVelocity = 256;
