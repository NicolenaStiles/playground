// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

// asteroids-specific
import '../asteroids.dart';
import 'components.dart';

class Joystick extends JoystickComponent
  with HasVisibility, TapCallbacks {

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
    super.findRootGame().runtimeType;
    if ((game as Asteroids).playState != PlayState.play) return false;
    if (game.findByKeyName<Player>('player') == null) return false;
    game.findByKeyName<Player>('player')!.isJoystickActive = true;
    (game as Asteroids).isJoystickActive = true;
    isVisible = true;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if ((game as Asteroids).playState != PlayState.play) return false;
    if ((game as Asteroids).findByKeyName<Player>('player') == null) return false;
    (game as Asteroids).findByKeyName<Player>('player')!.mobileMove = relativeDelta;
    (game as Asteroids).findByKeyName<Player>('player')!.mobilePercent = intensity;
    (game as Asteroids).findByKeyName<Player>('player')!.angleRequest = relativeDelta.screenAngle();
    return false;
  }

  @override
  void onDragStop() {
    super.onDragStop();
    if ((game as Asteroids).playState != PlayState.play) return;
    if ((game as Asteroids).findByKeyName<Player>('player') == null) return;
    (game as Asteroids).findByKeyName<Player>('player')!.isJoystickActive = false;
    (game as Asteroids).isJoystickActive = false;
    isVisible = false;
  }
}
