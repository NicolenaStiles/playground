import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GameState {
  mainMenu,
  textBoard,
  active,
}

class KeyboardExample extends FlameGame with KeyboardEvents {
  static const String description = '''
    Example showcasing how to act on keyboard events.
    It also briefly showcases how to create a game without the FlameGame.
    Usage: Use WASD to steer Ember.
  ''';

  late GameState _gameState;
  GameState get gameState => _gameState;
  set gameState(GameState gameState) {
    _gameState = gameState;
    switch (gameState) {
      case GameState.mainMenu:
        overlays.remove(GameState.textBoard.name);
        overlays.add(GameState.mainMenu.name);
        break;
      case GameState.textBoard:
        overlays.remove(GameState.mainMenu.name);
        overlays.add(GameState.textBoard.name);
        break;
      case GameState.active:
        overlays.remove(GameState.mainMenu.name);
        break;
    }
  }

  // Speed at which amber moves.
  static const double _speed = 200;

  // Direction in which amber is moving.
  final Vector2 _direction = Vector2.zero();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      CircleComponent(
        position: size / 2,
        radius: size.x / 20,
        paint: Paint()
               ..color = Colors.white
               ..style = PaintingStyle.fill,
      )
    );
    gameState = GameState.mainMenu;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameState != GameState.active) return;
    final ball = children.query<CircleComponent>().firstOrNull;
    final displacement = _direction.normalized() * _speed * dt;
    ball?.position.add(displacement);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    // Avoiding repeat event as we are interested only in
    // key up and key down event.
    if (key is! KeyRepeatEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyA) {
        _direction.x += isKeyDown ? -1 : 1;
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        _direction.x += isKeyDown ? 1 : -1;
      } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
        _direction.y += isKeyDown ? -1 : 1;
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        _direction.y += isKeyDown ? 1 : -1;
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        gameState = GameState.mainMenu;
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
