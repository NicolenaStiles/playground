// general dart stuff
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
import 'package:get_it/get_it.dart';
import '../src/api/site_state.dart';
import '../src/api/config.dart';

// player, asteroid, shot 
import 'components/components.dart';

// debug is only temp here
enum PlayState { 
  debug, 
  background, 
  mainMenu, 
  leaderboard,
  tutorial, 
  play, 
  replay,
  gameOver,
  gameOverAddScore,
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
  int lives = 0;
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

  // managing overlay state
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
      case PlayState.gameOverAddScore:
        overlays.add(playState.name);
      case PlayState.gameOver:
        overlays.remove(PlayState.gameOverAddScore.name);
        overlays.add(playState.name);
        break;
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;
 
    isMobile = getIt<SiteState>().isMobile;

    if (!isMobile) {
      getIt.registerSingleton<GameConfig>(GameConfig.desktop());
    } else {
      getIt.registerSingleton<GameConfig>(GameConfig.mobile(width,height));
    }
    
    lives = getIt<GameConfig>().playerLives;

    playState = PlayState.mainMenu;
    animateBackground(true);
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
      size : Vector2(
                getIt<GameConfig>().playerWidth, 
                getIt<GameConfig>().playerHeight),
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
           asteroidSize.x = getIt<GameConfig>().largeAsteroidSize; 
           asteroidSize.y = getIt<GameConfig>().largeAsteroidSize; 
          case AsteroidSize.medium:
           asteroidSize.x = getIt<GameConfig>().mediumAsteroidSize; 
           asteroidSize.y = getIt<GameConfig>().mediumAsteroidSize; 
          case AsteroidSize.small:
           asteroidSize.x = getIt<GameConfig>().smallAsteroidSize; 
           asteroidSize.y = getIt<GameConfig>().smallAsteroidSize; 
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
  // font size is inhereted from getIt<GameConfig>()
  //
  // component key name : 'scoreboard'
  void addScoreboard() {

    // scoreboard
    TextComponent scoreboard = TextComponent();
    TextStyle scoreStyle = TextStyle(color: Colors.white, 
                                     fontSize: getIt<GameConfig>().fontSize, 
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
  // sizing is all determined from logic in getIt<GameConfig>()
  //
  // component key names ; 'life3' , 'life2', 'life1'
  void addLivesTracker() {

    for (int n = 0; n < lives; n++) {
      String lifeKey = 'life$n';
      double xPos = width - (((n + 1) * getIt<GameConfig>().livesOffset) 
                                 + (n * getIt<GameConfig>().livesWidth) 
                                 + (getIt<GameConfig>().livesWidth / 2));
      double yPos = getIt<GameConfig>().livesOffset + (getIt<GameConfig>().livesHeight / 2);

      world.add(
        Lives(
          key: ComponentKey.named(lifeKey),
          position: Vector2(xPos, yPos),
          size : Vector2(getIt<GameConfig>().livesWidth, getIt<GameConfig>().livesHeight),
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
      key: ComponentKey.named('button_shoot'),
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
      size : Vector2(getIt<GameConfig>().playerWidth, getIt<GameConfig>().playerHeight),
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
       asteroidSize.x = getIt<GameConfig>().largeAsteroidSize; 
       asteroidSize.y = getIt<GameConfig>().largeAsteroidSize; 
      case AsteroidSize.medium:
       asteroidSize.x = getIt<GameConfig>().mediumAsteroidSize; 
       asteroidSize.y = getIt<GameConfig>().mediumAsteroidSize; 
      case AsteroidSize.small:
       asteroidSize.x = getIt<GameConfig>().smallAsteroidSize; 
       asteroidSize.y = getIt<GameConfig>().smallAsteroidSize; 
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
      if (countdown.finished && numAsteroids < getIt<GameConfig>().maxAsteroids) {
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
    lives = getIt<GameConfig>().playerLives;
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
    lives = getIt<GameConfig>().playerLives;
    numAsteroids = 0;
    countdown.stop();

    // lives tracker
    addLivesTracker();

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
        break;

      case PlayState.gameOverAddScore:
        if (isMobile) {
          joystick.isVisible = false;
          isJoystickActive = false;
        }
        break;

      case PlayState.gameOver:
        if (isMobile) {
          joystick.isVisible = false;
          isJoystickActive = false;
        }
        break;

    }
  }

  // tracks which tap accessed button
  int shootButtonTapId = 0;
  @override 
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);

    switch (_playState) {
      case PlayState.debug:
        return;
      case PlayState.background:
        return;
      case PlayState.mainMenu:
        return;
      case PlayState.leaderboard:
        return;
      case PlayState.tutorial:
        return;
      case PlayState.play:
        // gameplay input controls
        if (buttonShoot.containsPoint(info.eventPosition.widget)) {
          buttonShoot.isPressed = true;
          shootButtonTapId = pointerId;

        } else if (!isJoystickActive) {
          joystick.position = info.eventPosition.widget;
          joystick.isVisible = true;
          isJoystickActive = true;
        }
        return;
      case PlayState.replay:
        shootButtonTapId = 0;
        return;
      case PlayState.gameOverAddScore:
        buttonShoot.isPressed = false;
        return;
      case PlayState.gameOver:
        buttonShoot.isPressed = false;
        return;
    }
  }

  @override
  void onTapCancel(int pointerId) {
    super.onTapCancel(pointerId);

    switch (_playState) {
      case PlayState.debug:
        return;
      case PlayState.background:
        return;
      case PlayState.mainMenu:
        return;
      case PlayState.leaderboard:
        return;
      case PlayState.tutorial:
        return;
      case PlayState.play:
        // gameplay input controls
        if (pointerId == shootButtonTapId && buttonShoot.isPressed == true) {
          buttonShoot.isPressed = false;
          shootButtonTapId = 0;
        }
        return;
      case PlayState.replay:
        return;
      case PlayState.gameOverAddScore:
        buttonShoot.isPressed = false;
        return;
      case PlayState.gameOver:
        buttonShoot.isPressed = false;
        return;
    }
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);

    switch (_playState) {
      case PlayState.debug:
        return;
      case PlayState.background:
        startGame();
        return;
      case PlayState.mainMenu:
        return;
      case PlayState.leaderboard:
        return;
      case PlayState.tutorial:
        startGame();
        return;
      case PlayState.play:
        // gameplay input controls
        if (pointerId == shootButtonTapId && buttonShoot.isPressed == true) {
          buttonShoot.isPressed = false;
          shootButtonTapId = 0;
        }
        return;
      case PlayState.replay:
        return;
      case PlayState.gameOverAddScore:
        buttonShoot.isPressed = false;
        return;
      case PlayState.gameOver:
        buttonShoot.isPressed = false;
        return;
    }
  }

  @override
  KeyEventResult onKeyEvent( 
    KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    final isKeyDown = event is KeyDownEvent;
    final isKeyUp = event is KeyUpEvent;

    if (event is KeyRepeatEvent) {
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
