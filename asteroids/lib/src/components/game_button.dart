import 'package:flame/components.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';
import 'components.dart';

enum ButtonType {shoot, warp}


class GameButton extends CircleComponent 
  with HasGameRef<Asteroids> {

  final ButtonType type;
  bool isPressed = false;

  GameButton({
    required this.type,
    required super.position,
    required super.radius,
  }) : super ( 
    anchor: Anchor.center,
  );

  Paint _paintInactive = Paint();
  Paint _paintActive = Paint();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    switch (type) {
      case ButtonType.shoot:

        _paintInactive = Paint() 
          ..color = Colors.cyan
          ..style = PaintingStyle.stroke;

        _paintActive = Paint() 
          ..color = Colors.cyan
          ..style = PaintingStyle.fill;

      break;
      case ButtonType.warp:

        _paintInactive = Paint() 
          ..color = Colors.cyanAccent
          ..style = PaintingStyle.stroke;

        _paintActive = Paint() 
          ..color = Colors.cyanAccent
          ..style = PaintingStyle.fill;

      break;
    }
    paint = _paintInactive;
  }

  @override
  void update(dt) {
    super.update(dt);

    if (game.playState != PlayState.play) return;
    if (game.findByKeyName<Player>('player') == null) return;

    if (isPressed) {
      // shooting button
      if (type == ButtonType.shoot) {
        game.findByKeyName<Player>('player')!.fireShot = true; 
      }
      paint = _paintActive;
    } else {
      // shooting button
      if (type == ButtonType.shoot) {
        game.findByKeyName<Player>('player')!.fireShot = false; 
      }
      paint = _paintInactive;
    }
  }
}
