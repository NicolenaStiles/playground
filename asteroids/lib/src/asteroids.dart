// flame game-related stuff
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/debug.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

// general flutter packages
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

// configuration
import 'config.dart' as game_settings;

// player, asteroid, shot 
import 'components/components.dart';

// score style rendering
// TODO: something with font rendering is not working when deploying to pages.
// I may need to also just commit the files for now.
const testScoreStyle = GoogleFonts.pressStart2p;
const scoreStyle = TextStyle(color: Colors.white, 
                             fontSize: 48.0, 
                             fontFamily: 'Hyperspace');
final scoreRenderer = TextPaint(style: scoreStyle);

class Asteroids extends FlameGame
  with KeyboardEvents, HasCollisionDetection {

  double get width => size.x;
  double get height => size.y;

  int score = 0;
  int lives = game_settings.playerLives;
  
  // displaying score
  static TextComponent scoreboard = TextComponent();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    // setting up world constants
    // WARN: DEBUG ONLY
    world.add(
      FpsTextComponent(
        position: Vector2(0, canvasSize.y),
        anchor: Anchor.bottomLeft,
      )
    );

    world.add(Asteroid(
      objType: AsteroidType.asteroidX,
      objSize: AsteroidSize.large,
      velocity: 100.0,
      position: size * (3/4), 
      angle: 0
    ));

    world.add(Player(
      key: ComponentKey.named('player'),
      position: size / 2, 
      shipType: ShipType.player,
    ));

    // WARN: DEBUG ONLY 
    // debugMode = true;

    // display score
    String formattedScore = score.toString().padLeft(4, '0');
    scoreboard = TextComponent(
        key: ComponentKey.named('scoreboard'),
        text: formattedScore, 
        textRenderer: scoreRenderer,
        anchor: Anchor.topLeft,
        position: Vector2(0,0));
    world.add(scoreboard);

    // display lives
    for (int n = 0; n < lives; n++) {
      String lifeKey = "life$n";
      double xPos = canvasSize.x - (((n + 1) * game_settings.livesOffset) 
                                 + (n * game_settings.livesWidth) 
                                 + (game_settings.livesWidth / 2));
      world.add(
        Player(
          key: ComponentKey.named(lifeKey),
          position: Vector2(xPos, 
                            game_settings.livesOffset 
                              + (game_settings.livesHeight / 2)),
          shipType: ShipType.lives,
        )
      );
    }

  }

  // main gameplay loop
  @override 
  void update(double dt) {
    super.update(dt);
    // update scoreboard
    scoreboard.text = score.toString().padLeft(4, '0');
  }

  // TODO: Implement hyperdrive!
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
          findByKeyName<Player>('player')!.moveForward = true;
          //world.children.query<Player>().first.moveForward = true;
        // rotation
        case LogicalKeyboardKey.keyA: 
          findByKeyName<Player>('player')!.rotateLeft= true;
          //world.children.query<Player>().first.rotateLeft = true;
        case LogicalKeyboardKey.keyD: 
          findByKeyName<Player>('player')!.rotateRight= true;
          //world.children.query<Player>().first.rotateRight = true;
        // shooting
        case LogicalKeyboardKey.space: 
          findByKeyName<Player>('player')!.fireShot= true;
          //world.children.query<Player>().first.fireShot = true;
      } 

    } else if (isKeyUp) {
      switch (event.logicalKey) {
        // movement
        case LogicalKeyboardKey.keyW: 
          findByKeyName<Player>('player')!.moveForward= false;
          //world.children.query<Player>().first.moveForward = false;
        // rotation
        case LogicalKeyboardKey.keyA: 
          findByKeyName<Player>('player')!.rotateLeft = false;
          //world.children.query<Player>().first.rotateLeft = false;
        case LogicalKeyboardKey.keyD: 
          findByKeyName<Player>('player')!.rotateRight = false;
          //world.children.query<Player>().first.rotateRight = false;
        // shooting
        case LogicalKeyboardKey.space: 
          findByKeyName<Player>('player')!.fireShot = false;
          //world.children.query<Player>().first.fireShot = false;
      }
    }

    return KeyEventResult.handled;
  }

  @override 
  Color backgroundColor() => const Color(0xFF000000);

}
