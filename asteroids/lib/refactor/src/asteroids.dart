// flame game-related stuff
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/debug.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// configuration
import 'config.dart' as game_settings;

// play area
import 'components/components.dart';

// score style rendering
final scoreStyle = const TextStyle(color: Colors.white, fontSize: 48.0, fontFamily: 'Hyperspace');
final scoreRenderer = TextPaint(style: scoreStyle);

class Asteroids extends FlameGame
  with KeyboardEvents, HasCollisionDetection {

  double get width => size.x;
  double get height => size.y;

  int score = 0000;
  int lives = game_settings.playerLives;
  
  // displaying score
  static TextComponent scoreboard = TextComponent();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    // setting up world constants
    // WARN: DEBUG ONLY
    add(
      FpsTextComponent(
        position: Vector2(0, canvasSize.y),
        anchor: Anchor.bottomLeft,
      )
    );

    // TODO: how bad of an idea was it to remove this?

    //world.add(PlayArea());

    world.add(Asteroid(
      objType: AsteroidType.asteroidX,
      objSize: AsteroidSize.large,
      velocity: 10.0,
      position: size * (3/4), 
      angle: 0
    ));

    world.add(Player(
      key: ComponentKey.named("player"),
      position: size / 2, 
      size: Vector2(game_settings.playerWidthDesktop, 
                      game_settings.playerHeightDesktop),
    ));

    // WARN: DEBUG ONLY 
    debugMode = true;

    // display score
    String formattedScore = score.toString().padLeft(4, '0');
    scoreboard = TextComponent(
        key: ComponentKey.named('scoreboard'),
        text: formattedScore, 
        textRenderer: scoreRenderer,
        anchor: Anchor.topLeft,
        position: Vector2(0,0));
    add(scoreboard);

    // display lives
    for (int n = 0; n < lives; n++) {
      String lifeKey = "life$n";
      double xPos = canvasSize.x - (((n + 1) * game_settings.livesOffset) 
                                 + (n * game_settings.livesWidth) 
                                 + (game_settings.livesWidth / 2));
      add(
        Player(
          key: ComponentKey.named(lifeKey),
          position: Vector2(xPos, 
                            game_settings.livesOffset 
                            + (game_settings.livesHeight / 2)),
          size: Vector2(game_settings.livesWidth, 
                        game_settings.livesHeight),
        )
      );
    }

  }

  // main gameplay loop
  @override 
  void update(double dt) {
    super.update(dt);
    // update scoreboard
    // TODO: move this to asteroid collision handling?
    // ...or shot collision handling?
    scoreboard.text = score.toString().padLeft(4, '0');
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
        // shooting
        case LogicalKeyboardKey.space: 
          world.children.query<Player>().first.fireShot = true;

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
        // shooting
        case LogicalKeyboardKey.space: 
          world.children.query<Player>().first.fireShot = false;
      }
    }
    return KeyEventResult.handled;
  }

}
