import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';
import 'components.dart';

class Joystick extends JoystickComponent
  with HasVisibility, TapCallbacks, HasGameRef<Asteroids> {

  Joystick({
    required super.key,
    required super.position
  }) : super ( 
    knob: CircleComponent(
            radius: 20, 
            paint: Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill),

    background: CircleComponent(
                  radius: 50,  
                  paint: Paint()
                    ..color = Colors.white38
                    ..style = PaintingStyle.fill),
  );

  @override
  bool onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    game.findByKeyName<Player>('player')!.isJoystickActive = true;
    game.isJoystickActive = true;
    isVisible = true;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    game.findByKeyName<Player>('player')!.mobileMove = relativeDelta;
    game.findByKeyName<Player>('player')!.mobilePercent = intensity;
    game.findByKeyName<Player>('player')!.angleRequest = relativeDelta.screenAngle();
    return false;
  }

  @override
  void onDragStop() {
    super.onDragStop();
    game.findByKeyName<Player>('player')!.isJoystickActive = false;
    game.isJoystickActive = false;
    isVisible = false;
  }
}
