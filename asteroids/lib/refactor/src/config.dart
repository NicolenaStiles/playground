import 'package:flame/game.dart';

// NOTE: these are temp values for debugging viewport stuff. 
// the actual asteroids game will be fullscreen (probably)
// TODO: adjust these to work better with mobile players?
const gameHeight = 200.0;
const gameWidth = 300.0;

// Desktop sizing variants
// player
const double playerWidthDesktop = 36;
const double playerHeightDesktop = 60;

const double playerRotationSpeed = 0.06;    // tested, seems fine
Vector2 playerAcceleration = Vector2(4,4);  // untested
const int playerMaxSpeed = 400;             // untested

// shot
const int shotRadiusDesktop = 1;
const int shotSpeed = 800;        // how fast bullets go
const int shotTimer = 600;        // how long bullets live
const int currShotCooldown = 0;   // how long since last shoot bullet
const int shotCooldown = 32;      // how long until shoot bullets

// asteroids
const double largeAsteroidDesktop = 128.0; 
const double mediumAsteroidDesktop = 64.0; 
const double smallAsteroidDesktop = 32.0; 
const double asteroidSpeed = 300.0;

// WARN : I pulled these numbers out of my ass
const alienWidthDesktop = 60;
const alienHeightDesktop = 36;

// Mobile sizing variants
// TODO: how bad is this idea?
