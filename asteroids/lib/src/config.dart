import 'package:flame/game.dart';

// NOTE: these are temp values for debugging viewport stuff. 
// the actual asteroids game will be fullscreen (probably)
// THESE VALUES ARE NOT USED IN CURRENT IMPLEMENTAITON
const gameHeight = 200.0;
const gameWidth = 300.0;

// core gameplay mechanics
const int respawnTimer = 30;
const int playerLives = 3;

// TODO: change this into an upper and lower bound instead
const double asteroidSpeed = 120.0;

// Desktop sizing variants
// player 
const double playerWidthDesktop = 36;
const double playerHeightDesktop = 60;

const double playerRotationSpeed = 4; 
Vector2 playerAcceleration = Vector2(4,4);  // untested
const int playerMaxSpeed = 400;             // untested

// shot
const double shotRadiusDesktop = 4;
const double shotSpeed = 600;        // how fast bullets go
const double shotTimer = 100;        // how long bullets live
const double shotCooldown = 64;      // how long until shoot bullets

// asteroids
const double largeAsteroidDesktop = 128.0; 
const double mediumAsteroidDesktop = 64.0; 
const double smallAsteroidDesktop = 32.0; 

const int largeAsteroidPoints = 200;
const int mediumAsteroidPoints = 100;
const int smallAsteroidPoints = 50;

// I'm doing powers of 2 here
// only tested on desktop
const double asteroidMinVelocity = 32;
const double asteroidMaxVelocity = 256;

// lives tracker
// TODO: scale these by device?
const double livesWidth = 30;
const double livesHeight = 42;
const double livesOffset = 8;

// alien
// WARN : I pulled these numbers out of my ass
const alienWidthDesktop = 60;
const alienHeightDesktop = 36;

