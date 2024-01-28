// flame game-related stuff
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Custom componenets
import 'components/asteroid.dart';
import 'package:asteroids/components/shot.dart';
import 'package:asteroids/components/player.dart';

// utils
import 'dart:math';

// score style rendering
final scoreStyle = TextStyle(color: Colors.white, fontSize: 48.0, fontFamily: 'Hyperspace');
final scoreRenderer = TextPaint(style: scoreStyle);

class Asteroids extends FlameGame 
  with HasKeyboardHandlerComponents, HasCollisionDetection {

  // world size constants
  // TODO: window resize?
  static double worldMinX = 0;
  static double worldMinY = 0;
  static double worldMaxX = 0;
  static double worldMaxY = 0;

  // game state information
  static int score = 1234;
  static int lives = 3;

  // constants for displaying lives tracker
  static const double livesWidth = 30;
  static const double livesHeight = 42;
  static const double offset = 8;

  // player
  // constants
  static const int _rotationSpeed = 6;
  static final Vector2 _playerAcceleration = Vector2(4,4);
  // respawn specs 
  static const int respawnTimerMax = 1000;
  static int currentRespawnTimer = 0;
  // math for movement behaviors
  static Vector2 _playerVelocityInitial = Vector2(0,0);
  static Vector2 _playerVelocityFinal= Vector2(0,0);
  static final Vector2 _playerDisplacement = Vector2(0,0);
  static double _playerLastImpulseAngle = 0;
  static final Vector2 _playerDirection = Vector2(0,0);
  // the actual component
  late final Player player;

  // asteroid
  static const int asteroidSpeed = 300;
  late final Asteroid testAsteroid;

  // shot
  static int shotSpeed = 800;       // how fast bullets go
  static int shotTimer = 600;       // how long bullets live
  static int currShotCooldown = 0;  // how long since last shoot bullet
  static int shotCooldown = 32;     // how long until shoot bullets
  static bool shotReady = true;     // can we shoot

  // scoreboard
  static TextComponent scoreboard = TextComponent();

  // Keyboard handler map
  final Map<LogicalKeyboardKey, double> _keyWeights = {
    LogicalKeyboardKey.keyA: 0,
    LogicalKeyboardKey.keyD: 0,
    LogicalKeyboardKey.keyW: 0,
    LogicalKeyboardKey.space: 0,
  };

  @override
  Future<void> onLoad() async {

    await super.onLoad();

    // TODO: find a way to get rid of warning?
    worldMinX = camera.viewfinder.visibleWorldRect.left;
    worldMinY = camera.viewfinder.visibleWorldRect.bottom;
    worldMaxX = camera.viewfinder.visibleWorldRect.right;
    worldMaxY = camera.viewfinder.visibleWorldRect.top;

    // setting up world constants
    // NOTE: DEBUG ONLY
    add(
      FpsTextComponent(
        position: Vector2(0, canvasSize.y),
        anchor: Anchor.bottomLeft,
      )
    );

    // display score
    String formattedScore = score.toString().padLeft(4, '0');
    scoreboard = TextComponent(
        key: ComponentKey.named('scoreboard'),
        text: formattedScore, 
        textRenderer: scoreRenderer,
        anchor: Anchor.topLeft,
        position: Vector2(0, 0));
    add(scoreboard);

    // display lives
    for (int n = 0; n < lives; n++) {
      String lifeKey = "life$n";
      double xPos = canvasSize.x - (((n + 1) * offset) + (n * livesWidth) + (livesWidth / 2));
      add(
        Player(
          key: ComponentKey.named(lifeKey)
        )
        ..position = Vector2(xPos, offset + (livesHeight / 2))
        ..width = livesWidth
        ..height = livesHeight
      );
    }

    // populate the world
    player = Player() 
    ..position = Vector2(0, 0);
    // NOTE: DEBUG ONLY!!
    player.setGodmode(true);
    world.add(player);

    testAsteroid = Asteroid(AsteroidType.asteroidO, AsteroidSize.large) 
      ..position = Vector2(worldMinX,0)
      ..angle = 3 * (pi / 2)
      ..nativeAngle = 0;
    world.add(testAsteroid);

    // start listening for user input
    startKeyboardListener();

  }

  // game loop here
  @override
  void update(double dt) {

    super.update(dt);

    // are we shooting?
    handleShot();

    // move around all the stuff on screen
    for (var c in world.children) {
      
      if (c is Player) {
        movePlayer(dt);

      } else if (c is Asteroid) {
        moveAsteroid(c, dt);

      } else if (c is Shot) {
        moveShot(c, dt);
      }
    }

    // check if we can shoot
    if (!shotReady && currShotCooldown < shotCooldown) {
      currShotCooldown++;

    } else {
        shotReady = true;
      currShotCooldown = 0;

    }

    // update scoreboard
    scoreboard.text = score.toString().padLeft(4, '0');
  }

  // bring up KeyboardListener component
  void startKeyboardListener() {
    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, false),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, false),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, false),
          LogicalKeyboardKey.space: (keys) =>
              _handleKey(LogicalKeyboardKey.space, false),
        },
        keyDown: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, true),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, true),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, true),
          LogicalKeyboardKey.space: (keys) =>
              _handleKey(LogicalKeyboardKey.space, true),
        },
      ),
    );
  }

  // Updates for collions
  void updateScore(int points) => score += points;

  void updateLives(){
    String keyName = 'life${lives - 1}';
    if (findByKeyName<Player>(keyName) != null) {
      remove(findByKeyName<Player>(keyName)!);
    }
    lives--;
    player.setGodmode(true);
  }

  void updateInvulnerability() {
    if (currentRespawnTimer < respawnTimerMax){
      currentRespawnTimer++;
    } else {
      player.setGodmode(false);
      currentRespawnTimer = 0;
    }
  }

    
  // managing keyboard input
  bool _handleKey(LogicalKeyboardKey key, bool isDown) {
    _keyWeights[key] = isDown ? 1 : 0;
    return true;
  }

  // rotational input: uses keys D and A
  double get rInput =>
    _keyWeights[LogicalKeyboardKey.keyD]! -
    _keyWeights[LogicalKeyboardKey.keyA]!;

  // forward movement: uses W
  double get forwardMovement =>
    _keyWeights[LogicalKeyboardKey.keyW]!;

  // fire shot: uses spacebar
  double get fireShot =>
    _keyWeights[LogicalKeyboardKey.space]!;

  // Checks if PositionComponent should wrap around the game screen
  // (and moves it if it should)
  void checkWraparound(PositionComponent checkObj) {
    // wrapping around the screen: horizontal
    // right
    if (checkObj.position.x > (worldMaxX + checkObj.width)) {
      checkObj.position.x = worldMinX - checkObj.width / 2;
    // left
    } else if ((checkObj.position.x + checkObj.width) < worldMinX) {
      checkObj.position.x = worldMaxX + checkObj.width / 2;
    }
    // wrapping around the screen: vertical 
    // bottom
    if (checkObj.position.y < (worldMaxY - checkObj.height)) {
      checkObj.position.y = worldMinY - (checkObj.height / 2);
    } else if ((checkObj.position.y - checkObj.height) > worldMinY) {
      checkObj.position.y = worldMaxY - (checkObj.height / 2);
    }
  }

  // move player's ship based on input, time slice, and speed 
  // NOTE: these are not the same movement physics as in the OG version of 
  // asteroids!! they're modified slightly to encorage movement and discourage
  // camping ;)
  // NOTE: I should probably document the math here better? but it's in my
  // paper notes for 11/18/2023 if I need to go back and check.
  // TODO: add hyperdrive 

  void movePlayer(double dt) {

    // rotation update
    player.angle += rInput * (_rotationSpeed * dt);
    player.angle %= 2 * pi;

    // movement update
    double xInput = forwardMovement * sin(player.angle);
    double yInput = forwardMovement * (0 - cos(player.angle));

    _playerDirection 
    ..setValues(xInput, yInput)
    ..normalize();

    if (forwardMovement != 0) {
      _playerLastImpulseAngle = player.angle;
      _playerVelocityFinal = _playerVelocityInitial + (_playerAcceleration * dt);
      _playerDisplacement[0] = _playerDirection[0] * _playerVelocityFinal[0];
      _playerDisplacement[1] = _playerDirection[1] * _playerVelocityFinal[1];
      _playerVelocityInitial = _playerVelocityFinal;

      player.position.add(_playerDisplacement);

    } else {
      if (_playerVelocityFinal[0] > 0 && _playerVelocityFinal[1] > 0) {

        _playerVelocityFinal = _playerVelocityInitial - (_playerAcceleration * dt);
        _playerDisplacement[0] = sin(_playerLastImpulseAngle) * _playerVelocityFinal[0];
        _playerDisplacement[1] = (0 - cos(_playerLastImpulseAngle)) * _playerVelocityFinal[1];
        _playerVelocityInitial = _playerVelocityFinal;

        player.position.add(_playerDisplacement);

      } else {

        _playerVelocityInitial = Vector2(0,0);
        _playerVelocityFinal= Vector2(0,0);

      }
    }

    checkWraparound(player);
  }

  // moves an asteroid object based on current angle and time slice dt
  void moveAsteroid (Asteroid rock, double dt) {

    final Vector2 direciton = Vector2.zero();

    double xInput = sin(rock.angle);
    double yInput = 0 - cos(rock.angle);

    direciton 
      ..setValues(xInput,yInput)
      ..normalize();

    final displacementAsteroid = direciton * (asteroidSpeed * dt);
    rock.position.add(displacementAsteroid);
    // TODO: might wanna remove this if I switch to something that isn't just 
    // asteroids looping until they get killed
    checkWraparound(rock);
  }

  void handleShot(){
    if (shotReady == true && fireShot == 1){

      // calculate starting position for shot
      double shotPositionX = (player.position.x + sin(player.angle) * (player.height / 2));
      double shotPositionY = (player.position.y - cos(player.angle) * (player.height / 2));

      // create shot object
      world.add(
        Shot()
        ..position = Vector2(shotPositionX,shotPositionY)
        ..angle = player.angle
      );
      currShotCooldown = 0;
      shotReady = false;

    }
  }

  void moveShot(Shot shot, double dt){

    Vector2 directionShot = Vector2(0,0);
    // movement update
    directionShot
      ..setValues(sin(shot.angle), 0 - cos(shot.angle))
      ..normalize();

    final displacementShot = directionShot * (shotSpeed * dt);
    shot.position.add(displacementShot);
    shot.checkTimer(shotTimer);
 
  }

}
