import 'dart:async';

// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

// general flutter packages
import 'package:flutter/material.dart';

// player, asteroid, shot 
import 'components/components.dart';

// configuration
import 'config.dart' as game_settings;

game_settings.GameCfg testCfg = game_settings.GameCfg.desktop();

class MobileAsteroids extends FlameGame
  with MultiTouchTapDetector, HasCollisionDetection {

  // are we running on mobile?
  bool isMobile;
  MobileAsteroids(this.isMobile);

  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = game_settings.playerLives;

  // displaying debug info 
  static TextComponent tapIdsText = TextComponent();
  static TextComponent tapPosText = TextComponent();

  List<String> tapIdsList = [];
  List<String> tapPosList = []; 

  bool isJoystickActive = false;
  bool isButtonActive = false;

  // gesture input
  late final Joystick joystick;
  late final GameButton button;

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

    gestureDebug();
  }

  void gestureDebug() {

    // player's ship
    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (4/5);
    world.add(Player(
      key: ComponentKey.named('player'),
      position: shipPos,
      size : Vector2(testCfg.playerWidth, testCfg.playerHeight),
      isMobileGame: true,
    ));

    joystick = Joystick(
      key: ComponentKey.named('joystick'),
      position: size * (3 / 4),
    );
    joystick.isVisible = false;
    world.add(joystick);

    button = GameButton(
      type: ButtonType.shoot,
      radius: 50,
      position: Vector2(100, size.y - 100),
    );
    world.add(button);

    // debug info
    tapIdsText = TextComponent(
        key: ComponentKey.named('tapIds'),
        text: tapIdsList.toString(), 
        anchor: Anchor.topCenter,
        position: Vector2(width / 2, 0));
    world.add(tapIdsText);

    tapPosText = TextComponent(
        key: ComponentKey.named('tapPos'),
        text: tapPosList.toString(), 
        anchor: Anchor.topCenter,
        position: Vector2(width / 2, 40));
    world.add(tapPosText);
  }
  
  // handling tap events
  /*
  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    tapIdsText.text = "Tap down!";
    if (!buttonComponent.containsPoint(info.eventPosition.widget)) {
      isJoystickActive = true;
      joystick.position = info.eventPosition.widget;
      joystick.isVisible = true;
    }
  }

  @override
  void onTapCancel() {
    super.onTapCancel();
    tapIdsText.text = "Tap cancel!";
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    tapIdsText.text = "Tap up!";
    if (!buttonComponent.containsPoint(info.eventPosition.widget)) {
      isJoystickActive = false;
      joystick.isVisible = false;
    }
  }
  */

  // tracks which tap accessed button
  int buttonTapId = 0;

  @override 
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    if (button.containsPoint(info.eventPosition.widget)) {
      button.isPressed = true;
      buttonTapId = pointerId;
    } else if (!isJoystickActive) {
      joystick.position = info.eventPosition.widget;
      joystick.isVisible = true;
      isJoystickActive = true;
    }
  }

  @override
  void onTapCancel(int pointerId) {
    super.onTapCancel(pointerId);
    if (pointerId == buttonTapId && button.isPressed == true) {
      button.isPressed = false;
    }
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);
    if (pointerId == buttonTapId && button.isPressed == true) {
      button.isPressed = false;
    }
  }
}
