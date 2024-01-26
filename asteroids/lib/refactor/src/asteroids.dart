// flame game-related stuff
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

// configuration
import 'config.dart' as game_settings;

// play area
import 'components/components.dart';

class Asteroids extends FlameGame
  with KeyboardEvents, HasCollisionDetection {

  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    /*
    world.add(Asteroid(
      objType: AsteroidType.asteroidX,
      objSize: AsteroidSize.large,
      velocity: 100.0,
      position: size / 2, 
    ));
    */

    world.add(Player(
      position: size / 2, 
    ));

  }
  
  @override
  KeyEventResult onKeyEvent( 
    RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    final isKeyDown = event is RawKeyDownEvent;
    final isKeyUp = event is RawKeyUpEvent;

    if (event.repeat) {
      return KeyEventResult.handled;
    }

    if (isKeyDown) {
      switch (event.logicalKey) {
        // movement
        case LogicalKeyboardKey.keyW: 
          world.children.query<Player>().first.moveForward = true;
        // rotation
        case LogicalKeyboardKey.keyA: 
          world.children.query<Player>().first.rotateLeft = true;
        case LogicalKeyboardKey.keyD: 
          world.children.query<Player>().first.rotateRight = true;
      } 
    } else if (isKeyUp) {
      switch (event.logicalKey) {
        // movement
        case LogicalKeyboardKey.keyW: 
          world.children.query<Player>().first.moveForward = false;
        // rotation
        case LogicalKeyboardKey.keyA: 
          world.children.query<Player>().first.rotateLeft = false;
        case LogicalKeyboardKey.keyD: 
          world.children.query<Player>().first.rotateRight = false;
      }
    }
    return KeyEventResult.handled;
  }

}
