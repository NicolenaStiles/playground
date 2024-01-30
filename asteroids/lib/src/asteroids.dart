import 'dart:async';
import 'dart:math' as math;

// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

// general flutter packages
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// player, asteroid, shot 
import 'components/components.dart';

// configuration
import 'config.dart' as game_settings;

// enum PlayState {background, welcome, play, gameOver, won}
enum PlayState { background, play }

// scoreboard
const scoreStyle = TextStyle(color: Colors.white, 
                             fontSize: 48.0, 
                             fontFamily: 'Hyperspace');
final scoreRenderer = TextPaint(style: scoreStyle);

class Asteroids extends FlameGame
  with KeyboardEvents, HasCollisionDetection {

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = game_settings.playerLives;
 
  // displaying score
  static TextComponent scoreboard = TextComponent();

  // managing game state
  // mostly for controlling overlays tbh
  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.background:
      case PlayState.play:
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    playState = PlayState.background;
    animateBackground();
  }

  // TODO: create new config file for mobile/smaller screens?
  // (Rather than just having switch statements everywhere)
  void generateRandomAsteroid() {
    //Vector2 _asteroidPosition = Vector2(0, 0);

    // objType:
    // enum AsteroidType {asteroidO, asteroidS, asteroidX} 
    // objSize:
    // enum AsteroidSize {small, medium, large} 
    // velocity:
    // min = 32, max = 256
    // 2^5 -> 2^8
    print(math.pow(2, 5 + (rand.nextInt(4))).runtimeType);
    world.add(Asteroid(
      objType: AsteroidType.values[rand.nextInt(3)],
      objSize: AsteroidSize.values[rand.nextInt(3)],
      velocity: 256,
      position: size / 2,
      angle: 0,
    ));
  }

  void animateBackground () {

    generateRandomAsteroid();

    /*
    world.add(Asteroid(
      objType: AsteroidType.asteroidX,
      objSize: AsteroidSize.large,
      velocity: 120.0,
      position: Vector2 (0, height * (1/4)),
      angle: (math.pi / 2)
    ));

    world.add(Asteroid(
      objType: AsteroidType.asteroidX,
      objSize: AsteroidSize.small,
      velocity: 120.0,
      position: Vector2 (0, height * (1/4)),
      angle: -(math.pi / 2)
    ));

    world.add(Asteroid(
      objType: AsteroidType.asteroidO,
      objSize: AsteroidSize.large,
      velocity: 120.0,
      position: Vector2 (0, height * (2/4)),
      angle: -(math.pi / 2)
    ));

    world.add(Asteroid(
      objType: AsteroidType.asteroidS,
      objSize: AsteroidSize.large,
      velocity: 120.0,
      position: Vector2 (0, height * (3/4)),
      angle: -(math.pi / 2)
    ));
    */
  }

  void startGame() {

    // ignore call here if already playing
    if (playState == PlayState.play) return;

    // pull all the asteroids off the screen before we start
    world.removeAll(world.children.query<Asteroid>());

    playState = PlayState.play;

    score = 0;
    lives = game_settings.playerLives;

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
      velocity: 120.0,
      position: size * (1/4), 
      angle: 0
    ));

    world.add(Asteroid(
      objType: AsteroidType.asteroidS,
      objSize: AsteroidSize.large,
      velocity: 120.0,
      position: size * (3/4), 
      angle: 0
    ));

    world.add(Asteroid(
      objType: AsteroidType.asteroidO,
      objSize: AsteroidSize.large,
      velocity: 120.0,
      position: size * (2/4), 
      angle: 0
    ));

    world.add(Player(
      key: ComponentKey.named('player'),
      position: size / 3, 
      shipType: ShipType.player,
    ));

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
        case LogicalKeyboardKey.enter:
          startGame();
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
