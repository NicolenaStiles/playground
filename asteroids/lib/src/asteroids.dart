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

enum PlayState {
  idle,                 // background: animating but no engagement
  mainMenu,             // idle with main menu overlay
  leaderboard,          // idle with leaderboard overlay
  tutorial,             // gameplay info. HUD and ship loaded in
  play,                 // active play state
  gameOver,             // no ship/lives, but score still present
  addScore,             // same as above, but with text entry
}

// global state management
GetIt getIt = GetIt.instance;

class Asteroids extends FlameGame
  with MultiTouchTapDetector, KeyboardEvents, HasCollisionDetection {

  // core properties
  // meta
  bool isMobile = false;        // taken from getIt site state 
  double get width => size.x;   // convience/clarity access
  double get height => size.y;  // convience/clarity access

  // game stats
  int score = 0; 
  int lives = 0;                // taken from getIt configs
  int numAsteroids = 0;
  int maxAsteroids = 0;

  // user input
  late final Joystick joystick;
  late final GameButton buttonShoot;

  // ... and corresponding state
  bool isJoystickActive = false;
  bool isShootActive = false;

  // asteroid generation (background, game state, everything)
  final rand = math.Random();
  late Timer countdown = Timer(5);    // arbitrary value to ensure initalized

  // master game state logic (overlays and etc.)
  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.idle:
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
      // TODO: add overlay logic (rename?)
      case PlayState.gameOver:
        overlays.remove(PlayState.addScore.name);
        overlays.add(playState.name);
        break;
      // TODO: add overlay
      case PlayState.addScore:
        overlays.add(playState.name);
        break;
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;
 
    isMobile = getIt<SiteState>().isMobile;
  
    // define game configs based on play mode
    if (!isMobile) {
      getIt.registerSingleton<GameConfig>(GameConfig.desktop());
    } else {
      getIt.registerSingleton<GameConfig>(GameConfig.mobile(width,height));
    }
    
    lives = getIt<GameConfig>().playerLives;
    maxAsteroids = getIt<GameConfig>().maxAsteroids;
    
    // TODO: change the start mode to idle on port to website
    playState = PlayState.mainMenu;
    animateBackground(true);
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

  // HUD elements: scoreboard, lives
  // --------------------------------
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
      type: ButtonType.shoot, 
      position: shootPos, 
      radius: radius, 
    );
    
    world.add(buttonShoot);
  }

  // ensure all HUD components are loaded and zeroed out
  // if a component is already loaded, it just sets it back to default
  void resetHUD() {
    // scoreboard
    // TODO: magic number for score sig fig?
    if (findByKeyName<TextComponent>('scoreboard') != null) {
      findByKeyName<TextComponent>('scoreboard')!.text = score.toString().padLeft(4, '0');
    } else {
      addScoreboard();
    }

    // player lives
    world.removeAll(world.children.query<Lives>());
    addLivesTracker();

    if (isMobile) {
      // joystick
      // add if there isn't one, otherwise we're good
      if (findByKeyName<Joystick>('joystick') == null) {
        addJoystick();
      } 

      // shoot button
      // add if there isn't one, otherwise just hide it and make inactive 
      if (world.children.query<GameButton>().isEmpty) {
        addHudButtons();
      } else {
        buttonShoot.isVisible = true;
        buttonShoot.isPressed = false;
      }
    }
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

  void startGame() {
    // ignore call here if already playing
    if (playState == PlayState.play) return;

    // pull all the asteroids off the screen before we start
    world.removeAll(world.children.query<Asteroid>());

    playState = PlayState.play;

    // reset basic gameplay trackers first 
    score = 0;
    lives = getIt<GameConfig>().playerLives;
    numAsteroids = 0;
    countdown.stop();

    // set up HUD
    resetHUD();

    // add player
    addPlayerShip();
  }

  // standard gameplay loop
  // just generates new asteroids after whatever duration for now
  void gameplayLoop() {
    if (countdown.isRunning()) return;
    if (numAsteroids > maxAsteroids) return;

    countdown = Timer(rand.nextInt(16).toDouble());
    generateRandomAsteroid();
    countdown.start();
  }

  // main gameplay loop
  @override 
  void update(double dt) {
    super.update(dt);

    switch (_playState) {

      // TODO: implement idle 
      case PlayState.idle:
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
        numAsteroids = world.children.query<Asteroid>().length;
        break;

      case PlayState.play:
        countdown.update(dt);
        gameplayLoop();
        findByKeyName<TextComponent>('scoreboard')!.text = score.toString().padLeft(4, '0');
        numAsteroids = world.children.query<Asteroid>().length;
        break;

      case PlayState.addScore:
        animateBackground(false);
        if (isMobile) {
          joystick.isVisible = false;
          isJoystickActive = false;
        }
        break;

      case PlayState.gameOver:
        animateBackground(false);
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
    if (getIt<SiteState>().isMobile == false) return;
    super.onTapDown(pointerId, info);

    switch (_playState) {
      case PlayState.idle:
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
      // TODO: decide if this should be hidden?
      case PlayState.addScore:
        buttonShoot.isPressed = false;
        return;
      case PlayState.gameOver:
        buttonShoot.isPressed = false;
        return;
    }
  }

  @override
  void onTapCancel(int pointerId) {
    if (getIt<SiteState>().isMobile == false) return;
    super.onTapCancel(pointerId);

    switch (_playState) {
      case PlayState.idle:
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
      case PlayState.addScore:
        buttonShoot.isPressed = false;
        joystick.isVisible = false;
        return;
      case PlayState.gameOver:
        buttonShoot.isPressed = false;
        joystick.isVisible = false;
        return;
    }
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    if (getIt<SiteState>().isMobile == false) return;
    super.onTapUp(pointerId, info);

    switch (_playState) {
      case PlayState.idle:
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
      case PlayState.addScore:
        buttonShoot.isPressed = false;
        joystick.isVisible = false;
        return;
      case PlayState.gameOver:
        buttonShoot.isPressed = false;
        joystick.isVisible = false;
        return;
    }
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
