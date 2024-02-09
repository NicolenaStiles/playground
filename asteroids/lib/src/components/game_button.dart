import 'package:flame/components.dart';

import 'package:flutter/material.dart';

enum ButtonType {shoot, warp}

// TODO: 1. how determine if isMobile?

// TODO: 2. Pick a color pallette for these guys!
// I was just spitballing with these.

class GameButton extends CircleComponent {

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
    if (isPressed) {
      paint = _paintActive;
    } else {
      paint = _paintInactive;
    }
  }

}
