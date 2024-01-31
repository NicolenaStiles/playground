import 'package:flame/game.dart';

// core gameplay mechanics
const int playerLives = 3;
const int respawnTimer = 30;

// scoring
const int maxPoints = 10000;
const int largeAsteroidPoints = 200;
const int mediumAsteroidPoints = 100;
const int smallAsteroidPoints = 50;

// shot
const double shotSpeed = 600;        // how fast bullets go
const double shotTimer = 100;        // how long bullets live
const double shotCooldown = 64;      // how long until shoot bullets

// asteroids
