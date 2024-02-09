import 'package:flame/components.dart';

import 'package:flutter/material.dart';

class VirtualButton extends CircleComponent {

  VirtualButton({
    required super.position,
    required super.radius,
  }) : super ( 
    anchor: Anchor.center,
    paint: Paint() 
      ..color = Colors.cyan
     ..style = PaintingStyle.stroke,
 );

  bool isPressed = false;

  final _paintInactive = Paint() 
    ..color = Colors.cyan
    ..style = PaintingStyle.stroke;

  final _paintActive = Paint() 
    ..color = Colors.cyan
    ..style = PaintingStyle.fill;

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
