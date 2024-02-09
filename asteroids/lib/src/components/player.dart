import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';

import 'package:flutter/material.dart';

import 'dart:math';

//import '../asteroids.dart';
import '../mobile_asteroids.dart';
import '../config.dart' as game_settings;
import '../components/components.dart';

enum ShipType {player, lives}

class Player extends PositionComponent 
  with CollisionCallbacks, HasGameRef<MobileAsteroids> {

  // Rendering
  var _graphicPath = Path();
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  // TODO: bespoke hitbox?
  Player({
    required this.shipType,
    required this.isMobileGame,
    required super.key,
    required super.size,
    required super.position,
  }) : super ( 
    anchor: Anchor.center,
    children: [RectangleHitbox(isSolid: true)]
  ) {
    _graphicPath = completePath();
  }

  ShipType shipType;
  final bool isMobileGame;

  @override 
  Future<void> onLoad() async {
    super.onLoad();
    _graphicPath = completePath();
  }


  // movement input
  bool moveForward = false;
  bool rotateLeft = false;
  bool rotateRight = false;

  // mobile support
  bool isJoystickActive = false;
  Vector2 mobileMove = Vector2.zero();
  double mobilePercent = 0;
  double angleRequest = 0;
  static const double acceptableAngleError = 5; // in degrees

  // movement math
  double _playerLastImpulseAngle = 0;
  Vector2 _playerVelocityInitial = Vector2(0,0);
  Vector2 _playerVelocityFinal= Vector2(0,0);
  Vector2 _playerDisplacement = Vector2(0,0);
  Vector2 _playerDirection = Vector2(0,0);

  // handling shot
  bool fireShot = false;
  bool _shotReady = true;
  int _currShotCooldown = 0;

  // respawn stuff
  bool _godmode = false;
  int _currRespawnTimer = 0;


  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPath(_graphicPath, _paint);
  }

  // TODO: Add boosters animation!
  Path completePath() {

    _verticies = [];
    final graphicPath = Path();

    // A
    _verticies.add([ width * 0.5, 0]);
    // B
    _verticies.add([ width, height]);
    // C
    _verticies.add([ (width * 0.8), (height * 0.8) ]);
    // D
    _verticies.add([ (width * 0.2), (height * 0.8) ]);
    // E
    _verticies.add([ 0 , height]);

    graphicPath.moveTo(_verticies[0][0], _verticies[0][1]);
    for(int v = 1; v < _verticies.length; v++) {
      graphicPath.lineTo(_verticies[v][0], _verticies[v][1]);
    }
    graphicPath.lineTo(_verticies[0][0], _verticies[0][1]);

    return graphicPath;
  }

  void mobileTurn(double dt) {
    if (!isJoystickActive) return; // only run if we're recieving input

    // move to degrees 
    double rA = angleRequest * radians2Degrees;
    double cA = angle * radians2Degrees;

    // calculate error
    double eA = rA - cA;

    if (eA > 180) {
      eA -= 360;
    } else if (eA < -180) {
      eA += 360;
    }

    // exit early if we're under acceptable error
    if (eA.abs() < acceptableAngleError) return;

    // calculate next angle
    double nA = 0;
    if (eA > 0) {
      nA = cA + game_settings.mobilePlayerRotatationSpeed * dt;
    } else {
      nA = cA - game_settings.mobilePlayerRotatationSpeed * dt;
    }

    // if next angle is outside of bounds,
    // adjust within the (180/-180) limit
    if (nA > 180) {
      nA = (-180 + (nA % 180));
    } else if (nA < -180) {
      nA = (180 - (nA.abs() % 180));
    }

    // assign final value to angle
    angle = nA * degrees2Radians;
  }

  // handling rotation
  void turnLeft(double dt) {
    angle -= game_settings.playerRotationSpeed * dt;
    angle %= 2 * pi;
  }

  // handling rotation
  void turnRight(double dt) {
    angle += game_settings.playerRotationSpeed * dt;
    angle %= 2 * pi;
  }

  // Handling movement: including the glide-y stuff specific to asteroids!
  // TODO: add max speed!
  void movePlayer(double dt) {

    double xMove = sin(angle);
    double yMove = 0 - cos(angle);

    _playerDirection 
    ..setValues(xMove,yMove)
    ..normalize();

    if (moveForward) {

      _playerLastImpulseAngle = angle;
      _playerVelocityFinal = _playerVelocityInitial + (game_settings.playerAcceleration * dt);
      _playerDisplacement[0] = _playerDirection[0] * _playerVelocityFinal[0];
      _playerDisplacement[1] = _playerDirection[1] * _playerVelocityFinal[1];
      _playerVelocityInitial = _playerVelocityFinal;

      // actual position update
      position.add(_playerDisplacement);

    } else {

      if (_playerVelocityFinal[0] > 0 && _playerVelocityFinal[1] > 0) {

        _playerVelocityFinal = _playerVelocityInitial - (game_settings.playerAcceleration * dt);
        _playerDisplacement[0] = sin(_playerLastImpulseAngle) * _playerVelocityFinal[0];
        _playerDisplacement[1] = (0 - cos(_playerLastImpulseAngle)) * _playerVelocityFinal[1];
        _playerVelocityInitial = _playerVelocityFinal;

        // actual position update
        position.add(_playerDisplacement);

      } else {
        _playerVelocityInitial = Vector2(0,0);
        _playerVelocityFinal= Vector2(0,0);
      }
    }

    // check wraparound
    checkWraparound();
  }

  void mobileMovePlayer(double dt) {

    double xMove = sin(angle);
    double yMove = 0 - cos(angle);

    _playerDirection 
    ..setValues(xMove,yMove)
    ..normalize();
    
    //_playerDirection = mobileMove;
    //print('Player direction: ${_playerDirection.toString()}');
    //print('Mobile move: ${mobileMove.toString()}');
    //print('Percentage power: ${mobilePercent.toString()}');

    if (isJoystickActive) {

      _playerLastImpulseAngle = angle;
      _playerVelocityFinal = _playerVelocityInitial + (game_settings.mobilePlayerAcceleration * dt * mobilePercent);
      _playerDisplacement[0] = _playerDirection[0] * _playerVelocityFinal[0];
      _playerDisplacement[1] = _playerDirection[1] * _playerVelocityFinal[1];
      _playerVelocityInitial = _playerVelocityFinal;

      // actual position update
      position.add(_playerDisplacement);

    } else {

      if (_playerVelocityFinal[0] > 0 && _playerVelocityFinal[1] > 0) {

        _playerVelocityFinal = _playerVelocityInitial - (game_settings.mobilePlayerAcceleration * dt);
        _playerDisplacement[0] = sin(_playerLastImpulseAngle) * _playerVelocityFinal[0];
        _playerDisplacement[1] = (0 - cos(_playerLastImpulseAngle)) * _playerVelocityFinal[1];
        _playerVelocityInitial = _playerVelocityFinal;

        // actual position update
        position.add(_playerDisplacement);

      } else {
        _playerVelocityInitial = Vector2(0,0);
        _playerVelocityFinal= Vector2(0,0);
      }
    }

    // TODO: test this max speed!
    double maxPlayerVelocity = 4;
    if (_playerVelocityFinal.x > maxPlayerVelocity) {
      _playerVelocityFinal.x = maxPlayerVelocity;
    }
    if (_playerVelocityFinal.y > maxPlayerVelocity) {
      _playerVelocityFinal.y = maxPlayerVelocity;
    }

    // check wraparound
    checkWraparound();
  }

  // Checks if PositionComponent should wrap around the game screen
  // (and moves it if it should)
  void checkWraparound() {
    // wrapping around the screen: horizontal
    // right
   if (position.x > (game.size.x + width)) {
      position.x = 0 - width / 2;
    } else if ((position.x + width) < 0) {
      position.x = game.size.x + width / 2;
    }

    // wrapping around the screen: vertical 
    // bottom
    if (position.y > (game.size.y + height)) {
      position.y = 0 - (height / 2);
    } else if ((position.y + height) < 0 ) {
      position.y = game.size.y - (height / 2);
    }
  }

  // handles everything related to firing and managing shots
  void handleShot(fireShot) {

    // fire shot: add object to the world
    if (fireShot && _shotReady) {
      // calculate starting position for shot
      double shotPositionX = (position.x + sin(angle) * (size.x));
      double shotPositionY = (position.y - cos(angle) * (size.x));

      // create shot object
      game.world.add(
        Shot(
          position : Vector2(shotPositionX, shotPositionY),
          angle : angle
        )
      );
      _shotReady = false;
      _currShotCooldown = 0;
    } 

    // check if we can shoot
    if (!_shotReady && _currShotCooldown < game_settings.shotCooldown) {
      _currShotCooldown++;
    } else {
      _shotReady = true;
      _currShotCooldown = 0;
    }

  }

  void updateLives() {
    String keyName = 'life${game.lives - 1}';
    if (game.findByKeyName<Player>(keyName) != null) {
      game.world.remove(game.findByKeyName<Player>(keyName)!);
    }
    game.lives--;
    _godmode = true;
  }

  // TODO: visual indicator for invulnerability?
  void updateInvulnerability() {
    if (!_godmode) { 
      return;
    }
    if (_currRespawnTimer < game_settings.respawnTimer){
      _currRespawnTimer++;
    } else {
      _godmode = false;
      _currRespawnTimer = 0;
    }
  }

  // TODO: visual effect for collision?
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, 
                        PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // if not invincible
    // start animation?
    if (shipType == ShipType.lives) {
      return;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    
    if (shipType == ShipType.lives) {
      return;
    }

    if (_godmode != true) {
      // subtract a life and zero everything else out
      updateLives();
      position = Vector2(game.width / 2, game.height / 2);
      angle = 0;
      _playerLastImpulseAngle = 0;
      _playerVelocityInitial = Vector2(0,0);
      _playerVelocityFinal= Vector2(0,0);
      _playerDisplacement = Vector2(0,0);
      _playerDirection = Vector2(0,0);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (shipType == ShipType.lives) {
      return;
    }

    if (isMobileGame) {
      // movement
      mobileMovePlayer(dt);

      // rotation
      mobileTurn(dt);

      // shots: firing and managing cooldown
      handleShot(fireShot);

    } else {
      // movement
      movePlayer(dt);

      // rotation
      if (rotateRight) { turnRight(dt); }
      if (rotateLeft) { turnLeft(dt); }

      // shots: firing and managing cooldown
      handleShot(fireShot);
    }

    // handle invulnerability 
    updateInvulnerability();
  }
}
