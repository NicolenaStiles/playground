import 'dart:async';

// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

// general flutter packages
import 'package:flutter/material.dart';

// player, asteroid, shot 
import 'components/components.dart';

// configuration
import 'config.dart' as game_settings;

game_settings.GameCfg testCfg = game_settings.GameCfg.desktop();

class MobileAsteroids extends FlameGame
  with KeyboardEvents, HasCollisionDetection {
  bool isMobile;
  MobileAsteroids(this.isMobile);

  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = game_settings.playerLives;

  // displaying score
  static TextComponent scoreboard = TextComponent();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    // populate config object with appropriate settings
    if (!isMobile) {
      testCfg = game_settings.GameCfg.desktop();
    } else {
      testCfg = game_settings.GameCfg.mobile(width, height);
    }

    layoutDebug();
  }

  void layoutDebug() {
    
    // player's ship
    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (4/5);
    world.add(Player(
      key: ComponentKey.named('player'),
      position: shipPos,
      size : Vector2(testCfg.playerWidth, testCfg.playerHeight),
      shipType: ShipType.player,
      isMobileGame: isMobile,
    ));
    
    // asteroids
    for (var j = 3; j > 0; j--) {
      Vector2 asteroidPos = Vector2(0, 0);
      asteroidPos.y = (j / 5) * size.y;
      for (var i = 1; i < 4; i++) {
        asteroidPos.x = (i / 4) * size.x;
        Vector2 asteroidSize = Vector2(0, 0);
        // TODO: add same logic to random asteroid gen
        switch (AsteroidSize.values[j - 1]) {
          case AsteroidSize.large:
           asteroidSize.x = testCfg.largeAsteroidSize; 
           asteroidSize.y = testCfg.largeAsteroidSize; 
          case AsteroidSize.medium:
           asteroidSize.x = testCfg.mediumAsteroidSize; 
           asteroidSize.y = testCfg.mediumAsteroidSize; 
          case AsteroidSize.small:
           asteroidSize.x = testCfg.smallAsteroidSize; 
           asteroidSize.y = testCfg.smallAsteroidSize; 
        }
        world.add(Asteroid(
          objType: AsteroidType.values[i - 1],
          objSize: AsteroidSize.values[j - 1],
          velocity: 0,
          size: asteroidSize,
          position: asteroidPos, 
          angle: 0,
        ));
      }
    }

    // HUD stuff: scoreboard and lives tracker
    // scoreboard
    TextStyle scoreStyle = TextStyle(color: Colors.white, 
                                     fontSize: testCfg.fontSize, 
                                     fontFamily: 'Hyperspace');
    final scoreRenderer = TextPaint(style: scoreStyle);

    // score 
    String formattedScore = score.toString().padLeft(4, '0');
    scoreboard = TextComponent(
        key: ComponentKey.named('scoreboard'),
        text: formattedScore, 
        textRenderer: scoreRenderer,
        anchor: Anchor.topLeft,
        position: Vector2(0,0));
    world.add(scoreboard);

    // lives tracker
    for (int n = 0; n < lives; n++) {
      String lifeKey = "life$n";
      double xPos = width - (((n + 1) * testCfg.livesOffset) 
                                 + (n * testCfg.livesWidth) 
                                 + (testCfg.livesWidth / 2));
      double yPos = testCfg.livesOffset + (testCfg.livesHeight / 2);
      world.add(
        Player(
          key: ComponentKey.named(lifeKey),
          position: Vector2(xPos, yPos),
          size : Vector2(testCfg.livesWidth, testCfg.livesHeight),
          shipType: ShipType.lives,
          isMobileGame: isMobile,
        )
      );
    }
  }
}
