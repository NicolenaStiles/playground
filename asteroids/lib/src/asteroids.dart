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
game_settings.GameCfg testCfg = game_settings.GameCfg.desktop();

// WARN: Debug only!
String tapPosition = '';

// enum PlayState {background, welcome, play, gameOver, won}
enum PlayState { debug, background, play }

// scoreboard
const scoreStyle = TextStyle(color: Colors.white, 
                             fontSize: 48.0, 
                             fontFamily: 'Hyperspace');
final scoreRenderer = TextPaint(style: scoreStyle);

class Asteroids extends FlameGame
  with TapDetector, KeyboardEvents, HasCollisionDetection {
  bool isMobile;
  Asteroids(this.isMobile);

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = game_settings.playerLives;
  int numAsteroids = 0;
 
  // displaying score
  static TextComponent scoreboard = TextComponent();
  static TextComponent tapTracker = TextComponent();
  static TextComponent tapTracker2 = TextComponent();

  TextComponent dist = TextComponent();
  TextComponent ang = TextComponent();

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

    // populate config object with appropriate settings
    if (!isMobile) {
      testCfg = game_settings.GameCfg.desktop();
    } else {
      testCfg = game_settings.GameCfg.mobile(width, height);
    }

    debugMode = true;

    gestureDebug();

    // playState = PlayState.background;
    // animateBackground(true);
    
    // layoutDebug();

    /*
    playState = PlayState.background;
    animateBackground(true);
    */
  }

  void gestureDebug () {

    dist = TextComponent(
                key: ComponentKey.named('dist'), 
                text: '',
                position: Vector2(canvasSize.x / 2, 0),
                anchor: Anchor.topCenter);
    world.add(dist);

    ang = TextComponent(
                key: ComponentKey.named('ang'), 
                text: '',
                position: Vector2(canvasSize.x / 2, 40),
                anchor: Anchor.topCenter);
    world.add(ang);

    world.add(
      VirtualJoystick(
        key: ComponentKey.named('joystick'), 
        radius: 200, 
        position: Vector2(size.x / 2, size.y * (3 / 4))));

  }

  // layout all the assets to determine if screen sizing is trash or not
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
    ));
    
    // asteroids
    for (var j = 3; j > 0; j--) {
      Vector2 asteroidPos = Vector2(0, 0);
      asteroidPos.y = (j / 5) * size.y;
      for (var i = 1; i < 4; i++) {
        asteroidPos.x = (i / 4) * size.x;
        Vector2 asteroidSize = Vector2(0, 0);
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
        )
      );
    }
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
    Vector2 asteroidSize = Vector2(0, 0);
    AsteroidSize asteroidSizeEnum = AsteroidSize.values[rand.nextInt(3)]; 
    switch (asteroidSizeEnum) {
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
      objType: AsteroidType.values[rand.nextInt(3)],
      objSize: asteroidSizeEnum,
      velocity: asteroidVelocity,
      size: asteroidSize,
      position: asteroidPos,
      angle: asteroidAngle,
    ));
    numAsteroids++;
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
    /*
    world.add(
      FpsTextComponent(
        position: Vector2(0, canvasSize.y),
        anchor: Anchor.bottomLeft,
      )
    );
    */

    // WARN: DEBUG ONLY
    tapTracker = TextComponent(
                    key: ComponentKey.named('tap'), 
                    text: '',
                    position: Vector2(0, canvasSize.y),
                    anchor: Anchor.bottomLeft);
    world.add(tapTracker);

    tapTracker2 = TextComponent(
                    key: ComponentKey.named('tap2'), 
                    text: '',
                    position: Vector2(canvasSize.x / 2, canvasSize.y),
                    anchor: Anchor.bottomCenter);
    world.add(tapTracker2);

    /*
    // player's ship
    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (4/5);
    world.add(Player(
      key: ComponentKey.named('player'),
      position: shipPos,
      size : Vector2(testCfg.playerWidth, testCfg.playerHeight),
      shipType: ShipType.player,
    ));
    */

    // display score
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
        )
      );
    }

  }

  /*
  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (_playState == PlayState.background) {
      startGame();
    }
    tapPosition = info.eventPosition.global.toString();
    tapTracker2.text = 'tap down';
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

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
    tapPosition = info.eventPosition.global.toString();
    tapTracker2.text = 'pan update';
  }

  @override
  void onPanStart(DragStartInfo info) {
    super.onPanStart(info);
    tapPosition = info.eventPosition.global.toString();
    tapTracker2.text = 'pan start';
  }

  @override
  void onPanEnd(DragEndInfo info) {
    super.onPanEnd(info);
    tapTracker2.text = 'pan end';
  }


  @override
  void onLongPressStart(LongPressStartInfo info) {
    super.onLongPressStart(info);
    tapTracker.text = info.eventPosition.global.toString();
    tapTracker2.text = 'long press start';
  }

  @override
    void onLongPressMoveUpdate(LongPressMoveUpdateInfo info) {
      super.onLongPressMoveUpdate(info);
      tapTracker.text = info.eventPosition.global.toString();
      tapTracker2.text = 'long press move update';
    }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    super.onLongPressEnd(info);
    tapTracker.text = info.eventPosition.global.toString();
    tapTracker2.text = 'long press end';
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (_playState == PlayState.background) {
      startGame();
    }
    tapPosition = info.eventPosition.global.toString();
    tapTracker2.text = 'tap down';
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    tapPosition = info.eventPosition.global.toString();
    tapTracker2.text = 'tap up';
  }

  */

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
