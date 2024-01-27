import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flutter/material.dart';

import 'dart:math';

import '../asteroids.dart';
import '../config.dart' as game_settings;
import '../components/components.dart';

class Player extends PositionComponent 
  with CollisionCallbacks, HasGameRef<Asteroids> {

  // TODO: bespoke hitbox?
  // TODO: how determine platform?
  Player({
    required super.key,
    required super.position,
    required super.size
  }) : super ( 
        anchor: Anchor.center,
        /*
        size: Vector2(game_settings.playerWidthDesktop, 
                      game_settings.playerHeightDesktop),
        */
        children: [RectangleHitbox(isSolid: true)]
  );

  // movement input
  bool moveForward = false;
  bool rotateLeft = false;
  bool rotateRight = false;

  // movement math
  double _playerLastImpulseAngle = 0;
  Vector2 _playerVelocityInitial = Vector2(0,0);
  Vector2 _playerVelocityFinal= Vector2(0,0);
  final Vector2 _playerDisplacement = Vector2(0,0);
  final Vector2 _playerDirection = Vector2(0,0);

  // handling shot
  bool fireShot = false;
  bool _shotReady = true;
  int _currShotCooldown = 0;

  // respawn stuff
  // WARN: Debug only!
  bool _godmode = true;
  int _currRespawnTimer = 0;

  // Rendering
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPath(completePath(), _paint);
  }

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

  // handling rotation
  void rotateBy(double dr) {
    add(RotateEffect.by(
      dr, 
      EffectController(duration: 0) 
    ));
  }

  // Handling movement: including the glide-y stuff specific to asteroids!
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

      add(MoveByEffect(
        Vector2( 
          _playerDisplacement[0],
          _playerDisplacement[1]
        ),
        EffectController(duration: 0))
      );

    } else {

      if (_playerVelocityFinal[0] > 0 && _playerVelocityFinal[1] > 0) {

        _playerVelocityFinal = _playerVelocityInitial - (game_settings.playerAcceleration * dt);
        _playerDisplacement[0] = sin(_playerLastImpulseAngle) * _playerVelocityFinal[0];
        _playerDisplacement[1] = (0 - cos(_playerLastImpulseAngle)) * _playerVelocityFinal[1];
        _playerVelocityInitial = _playerVelocityFinal;

        add(MoveByEffect(
          Vector2( 
            _playerDisplacement[0],
            _playerDisplacement[1]
          ),
          EffectController(duration: 0))
        );

      } else {

        _playerVelocityInitial = Vector2(0,0);
        _playerVelocityFinal= Vector2(0,0);
      }
    }

  }

  // handles everything related to firing and managing shots
  void handleShot(fireShot) {

    // fire shot: add object to the world
    if (fireShot && _shotReady) {
      // calculate starting position for shot
      double shotPositionX = (position.x + sin(angle) * (height / 2));
      double shotPositionY = (position.y - cos(angle) * (height / 2));

      // create shot object
      game.world.add(
        Shot(
          position : Vector2(shotPositionX,shotPositionY),
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

  // WARN: lol this ain't right
  // TODO: this logic isn't quite right? respawn timer not implemented
  void updateLives(){
    String keyName = 'life${game.lives - 1}';
    if (game.findByKeyName<Player>(keyName) != null) {
      remove(game.findByKeyName<Player>(keyName)!);
    }
    game.lives--;
    _godmode = true;
  }

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

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, 
                        PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // if not invincible
    // start animation?
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (!_godmode) {
      updateLives();
      position = Vector2(0, 0);
    }
  }


  @override
  void update(double dt) {
    super.update(dt);

    // rotation
    if (rotateRight) {
      rotateBy(game_settings.playerRotationSpeed);
    } else if (rotateLeft) {
      rotateBy(-game_settings.playerRotationSpeed);
    }

    // movement
    movePlayer(dt);

    // shots: firing and managing cooldown
    handleShot(fireShot);

    // handle invulnerability 
    updateInvulnerability();

  }
}
