import 'dart:async';
import 'dart:math' as math;

// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

// general flutter packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// global state management
import '../src/api/site_state.dart';

// player, asteroid, shot 
import 'package:get_it/get_it.dart';
import 'components/components.dart';

// configuration
import 'config.dart' as game_settings;
game_settings.GameCfg testCfg = game_settings.GameCfg.desktop();

// debug is only temp here
// TODO: maybe add "replay" as state?
enum PlayState { 
  debug, 
  background, 
  mainMenu, 
  leaderboard,
  tutorial, 
  play, 
  replay,
  gameOver,
}

// global state management
GetIt getIt = GetIt.instance;

class Asteroids extends FlameGame
  with MultiTouchTapDetector, KeyboardEvents, HasCollisionDetection {

  bool isMobile = false;

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = game_settings.playerLives;
  int numAsteroids = 0;

  // gesture input
  late final Joystick joystick;
  late final GameButton buttonShoot;

  // gesture state
  bool isJoystickActive = false;
  bool isShootActive = false;
  bool isWarpActive = false;

  // timer things
  late Timer countdown;

  // managing game state
  // TODO: add overlay logic here
  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.debug:
        break;
      case PlayState.background:
        break;
      case PlayState.mainMenu:
        overlays.remove(PlayState.leaderboard.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.add(playState.name);
        break;
      case PlayState.leaderboard:
        overlays.remove(PlayState.mainMenu.name);
        overlays.add(playState.name);
        break;
      case PlayState.tutorial:
        overlays.remove(PlayState.mainMenu.name);
        overlays.add(playState.name);
        break;
      case PlayState.play:
        overlays.remove(PlayState.tutorial.name);
        overlays.remove(PlayState.gameOver.name);
        break;
      case PlayState.replay:
        overlays.remove(PlayState.gameOver.name);
        break;
      case PlayState.gameOver:
        overlays.add(playState.name);
        break;
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;
 
    // WARN: debug only
    // populate config object with appropriate settings
    isMobile = getIt<SiteState>().isMobile;

    if (!isMobile) {
      testCfg = game_settings.GameCfg.desktop();
    } else {
      testCfg = game_settings.GameCfg.mobile(width, height);
    }

    playState = PlayState.mainMenu;
    animateBackground(true);

    //playState = PlayState.debug;
    //layoutDebug();
  }

  // testing gesture layout stuff
  void layoutHUDDebug() {

    // HUD stats
    addScoreboard();
    addLivesTracker();

    // HUD controls
    addJoystick();
    addHudButtons();

    // and finally player ship
    addPlayerShip();
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
      isMobileGame: isMobile,
    ));

    // test alien
    Vector2 alienPos = Vector2(0, 0);
    alienPos.x = size.x * (1/3);
    alienPos.y = size.y * (4/5);
    world.add(Alien(
      key: ComponentKey.named('alien'),
      size: Vector2(64, 48), 
      position: alienPos
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
  }

  // HUD elements: scoreboard, lives
  // adding the scoreboard to the HUD
  // font size is inhereted from testCfg
  //
  // component key name : 'scoreboard'
  void addScoreboard() {

    // scoreboard
    TextComponent scoreboard = TextComponent();
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
  }

  // adding the lives tracker to the HUD
  // sizing is all determined from logic in testCfg
  //
  // component key names ; 'life3' , 'life2', 'life1'
  void addLivesTracker() {

    for (int n = 0; n < lives; n++) {
      String lifeKey = 'life$n';
      double xPos = width - (((n + 1) * testCfg.livesOffset) 
                                 + (n * testCfg.livesWidth) 
                                 + (testCfg.livesWidth / 2));
      double yPos = testCfg.livesOffset + (testCfg.livesHeight / 2);

      world.add(
        Lives(
          key: ComponentKey.named(lifeKey),
          position: Vector2(xPos, yPos),
          size : Vector2(testCfg.livesWidth, testCfg.livesHeight),
        )
      );
    }
  }
  
  // Mobile only: Add gesture control elements
  // adding joystick
  //
  // component name : 'joystick'
  void addJoystick() {

    joystick = Joystick(
      key: ComponentKey.named('joystick'),
      position: size * (3 / 4),
    );
    joystick.isVisible = false;
    world.add(joystick);
  }

  // adding buttons to the HUD
  // no component keys here :(
  void addHudButtons() {

    double radius = 40;
    double margin = 10;

    Vector2 shootPos = Vector2(
                          margin + radius, 
                          size.y - (margin + radius));

    buttonShoot = GameButton(
      type: ButtonType.shoot, 
      position: shootPos, 
      radius: radius, 
    );
    
    world.add(buttonShoot);
  }

  // Game components: player, joystick, etc.
  // adding player ship to the game
  // edit "shipPos" to change where it spawns in
  //
  // component name : 'player'
  void addPlayerShip() {

    // player's ship
    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (1/2);
    world.add(Player(
      key: ComponentKey.named('player'),
      position: shipPos,
      size : Vector2(testCfg.playerWidth, testCfg.playerHeight),
      isMobileGame: isMobile,
    ));
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
  }

  // generate background asteroids for Ze Aesthetique
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

  // stand up and start game
  void startGame() {

    // ignore call here if already playing
    if (playState == PlayState.play) return;

    // pull all the asteroids off the screen before we start
    world.removeAll(world.children.query<Asteroid>());

    playState = PlayState.play;

    score = 0;
    lives = game_settings.playerLives;
    numAsteroids = 0;
    countdown.stop();

    // display score
    addScoreboard();

    // lives tracker
    addLivesTracker();

    // add controls for mobile
    if (isMobile) {
      addJoystick();
      addHudButtons();
    }

    // add player
    addPlayerShip();
  }

  // main loop for gameplay
  int maxAsteroids = 5;
  void gameplayLoop() {

    if (countdown.isRunning()) return;
    if (numAsteroids > maxAsteroids) return;

    countdown = Timer(rand.nextInt(16).toDouble());
    generateRandomAsteroid();
    countdown.start();
  }

  void startReplay() {

    // pull all the asteroids off the screen before we start
    world.removeAll(world.children.query<Asteroid>());

    playState = PlayState.play;

    score = 0;
    lives = game_settings.playerLives;
    numAsteroids = 0;
    countdown.stop();

    // lives tracker
    addLivesTracker();

    // add controls for mobile
    if (isMobile) {
      addJoystick();
      addHudButtons();
    }

    // add player
    addPlayerShip();
  }

  // main gameplay loop
  @override 
  void update(double dt) {
    super.update(dt);

    switch (_playState) {
      case PlayState.debug:
        break;

      case PlayState.background:
        countdown.update(dt);
        animateBackground(false);
        numAsteroids = world.children.query<Asteroid>().length;
        break;

      case PlayState.mainMenu:
        countdown.update(dt);
        animateBackground(false);
        numAsteroids = world.children.query<Asteroid>().length;
        break;

      case PlayState.leaderboard:
        countdown.update(dt);
        animateBackground(false);
        numAsteroids = world.children.query<Asteroid>().length;
        break;

      case PlayState.tutorial:
        countdown.update(dt);
        animateBackground(false);
        numAsteroids = world.children.query<Asteroid>().length;
        break;

      case PlayState.play:
        countdown.update(dt);
        gameplayLoop();
        findByKeyName<TextComponent>('scoreboard')!.text = score.toString().padLeft(4, '0');
        numAsteroids = world.children.query<Asteroid>().length;
        break;

      case PlayState.replay:
        startReplay();

      // TODO: manage game over update
      case PlayState.gameOver:
        break;

    }
  }

  // tracks which tap accessed button
  int shootButtonTapId = 0;
  @override 
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);

    if (_playState == PlayState.background ||
        _playState == PlayState.tutorial) {
        return; 
    }

    // gameplay input controls
    if (buttonShoot.containsPoint(info.eventPosition.widget)) {
      buttonShoot.isPressed = true;
      shootButtonTapId = pointerId;

    } else if (!isJoystickActive) {
      joystick.position = info.eventPosition.widget;
      joystick.isVisible = true;
      isJoystickActive = true;
    }
  }

  @override
  void onTapCancel(int pointerId) {
    super.onTapCancel(pointerId);

    // gameplay input controls
    if (pointerId == shootButtonTapId && buttonShoot.isPressed == true) {
      buttonShoot.isPressed = false;
      shootButtonTapId = 0;
    }
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);

    // start game if running in background on tap
    if (_playState == PlayState.background ||
        _playState == PlayState.tutorial) {
      startGame();
    }

    // gameplay input controls
    if (pointerId == shootButtonTapId && buttonShoot.isPressed == true) {
      buttonShoot.isPressed = false;
      shootButtonTapId = 0;
    }
  }

  // TODO: Implement hyperdrive!
  // TODO: handle misclicks/incorrect keypress/taps
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
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.moveForward = true; } 
        // rotation
        case LogicalKeyboardKey.keyA: 
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.rotateLeft = true; }

        case LogicalKeyboardKey.keyD: 
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.rotateRight = true; }

        // shooting
        case LogicalKeyboardKey.space: 
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.fireShot = true; }

      } 
    } else if (isKeyUp) {
      switch (event.logicalKey) {

        // movement
        case LogicalKeyboardKey.keyW: 
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.moveForward = false; }

        // rotation
        case LogicalKeyboardKey.keyA: 
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.rotateLeft = false; }

        case LogicalKeyboardKey.keyD: 
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.rotateRight = false; }

        // shooting
        case LogicalKeyboardKey.space: 
          if (_playState == PlayState.play) {
            findByKeyName<Player>('player')!.fireShot = false; }
          else if (_playState == PlayState.tutorial) {
            startGame(); }

        case LogicalKeyboardKey.enter:
          if (_playState == PlayState.tutorial) {
            startGame(); }

      }
    }
    return KeyEventResult.handled;
  }

  @override 
  Color backgroundColor() => const Color(0xFF000000);

}
