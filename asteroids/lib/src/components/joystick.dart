// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

// asteroids-specific
import '../asteroids.dart';
import 'components.dart';

// FIX: Breaking change involving HasGameReference in v1.15
// Can't bump version because the mixin is provided in JoystickComponent
// Need to either find direct fix to mixin conflict or rework 

class Joystick extends JoystickComponent
  with HasVisibility, TapCallbacks, HasGameReference<Asteroids> {

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
    if (game.playState != PlayState.play) return false;
    if (game.findByKeyName<Player>('player') == null) return false;
    game.findByKeyName<Player>('player')!.isJoystickActive = true;
    game.isJoystickActive = true;
    isVisible = true;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (game.playState != PlayState.play) return false;
    if (game.findByKeyName<Player>('player') == null) return false;
    game.findByKeyName<Player>('player')!.mobileMove = relativeDelta;
    game.findByKeyName<Player>('player')!.mobilePercent = intensity;
    game.findByKeyName<Player>('player')!.angleRequest = relativeDelta.screenAngle();
    return false;
  }

  @override
  void onDragStop() {
    super.onDragStop();
    if (game.playState != PlayState.play) return;
    if (game.findByKeyName<Player>('player') == null) return;
    game.findByKeyName<Player>('player')!.isJoystickActive = false;
    game.isJoystickActive = false;
    isVisible = false;
  }
}
