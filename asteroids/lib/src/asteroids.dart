import 'dart:async';
import 'dart:math' as math;

// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

// general flutter packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// player, asteroid, shot 
import 'components/components.dart';

// configuration
import 'config.dart' as game_settings;

// enum PlayState {background, welcome, play, gameOver, won}
enum PlayState { debug, background, play }

// scoreboard
const scoreStyle = TextStyle(color: Colors.white, 
                             fontSize: 48.0, 
                             fontFamily: 'Hyperspace');
final scoreRenderer = TextPaint(style: scoreStyle);

// TODO: create new config file for mobile/smaller screens?
// (Rather than just having switch statements everywhere)
class Asteroids extends FlameGame
  with KeyboardEvents, HasCollisionDetection {

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = game_settings.playerLives;
  int numAsteroids = 0;
 
  // displaying score
  static TextComponent scoreboard = TextComponent();

  // timer things
  late Timer countdown;

  // managing game state
  // mostly for controlling overlays tbh
  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.debug:
      case PlayState.background:
      case PlayState.play:
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    playState = PlayState.debug;
    // WARN: debug only!
    layoutDebug();

    /*
    playState = PlayState.background;
    animateBackground(true);
    */
  }

  void generateRandomAsteroid() {
    // generate random velocity value
    // 32, 64, 128, 256 as possible speed
    int asteroidSpeedScalar = rand.nextInt(4);
    double asteroidVelocity = math.pow(2, (5 + asteroidSpeedScalar)).toDouble();

    // generate position values
    Vector2 asteroidPos = Vector2(0, 0);
    bool isSide = rand.nextBool();
    if (isSide) {
      asteroidPos.y = ((rand.nextDouble() * (height / 2)  + (height / 4)));
    } else {
      asteroidPos.x = ((rand.nextDouble() * (width / 2)  + (width / 4)));
    }

    // generate angle
    final bool isPositiveAngle = rand.nextBool();
    double asteroidAngle = (rand.nextDouble() * (math.pi / 2)) 
                              + (math.pi / 4);
    if (!isPositiveAngle) {  
      asteroidAngle = -asteroidAngle; 
    }

    // objType:
    // enum AsteroidType {asteroidO, asteroidS, asteroidX} 
    // objSize:
    // enum AsteroidSize {small, medium, large} 
    // velocity:
    // min = 32, max = 256
    // 2^5 -> 2^8
    world.add(Asteroid(
      objType: AsteroidType.values[rand.nextInt(3)],
      objSize: AsteroidSize.values[rand.nextInt(3)],
      velocity: asteroidVelocity,
      position: asteroidPos,
      angle: asteroidAngle,
    ));
    numAsteroids++;
  }

  // layout all the assets to determine if screen sizing is trash or not
  void layoutDebug() {

    for (var j = 3; j > 0; j--) {
      Vector2 asteroidPos = Vector2(0, 0);
      asteroidPos.y = (j / 5) * size.y;
      for (var i = 1; i < 4; i++) {
        asteroidPos.x = (i / 4) * size.x;
        world.add(Asteroid(
          objType: AsteroidType.values[i - 1],
          objSize: AsteroidSize.values[j - 1],
          velocity: 0,
          position: asteroidPos, 
          angle: 0,
        ));
      }
    }

    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (4/5);
    // player's ship
    world.add(Player(
      key: ComponentKey.named('player'),
      position: shipPos,
      shipType: ShipType.player,
    ));

    // score 
    String formattedScore = score.toString().padLeft(4, '0');
    scoreboard = TextComponent(
        key: ComponentKey.named('scoreboard'),
        text: formattedScore, 
        textRenderer: scoreRenderer,
        anchor: Anchor.topLeft,
        position: Vector2(0,0));
    world.add(scoreboard);

    // lives
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

  void animateBackground (bool isFirstRun) {

    if (isFirstRun) {
      generateRandomAsteroid();
      countdown = Timer(5);
      countdown.start();

    } else {
      if (countdown.finished && numAsteroids < 10) {
        generateRandomAsteroid();
        countdown = Timer(5);
        countdown.start();
      }
    }
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

    // if we're still animating the background, just keep doing that
    if (_playState == PlayState.background) {
      // update timer
      countdown.update(dt);
      animateBackground(false);
    // switching to playing the game
    } else if (_playState == PlayState.play) {
      // update scoreboard
      scoreboard.text = score.toString().padLeft(4, '0');
    }
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
