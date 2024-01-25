// flame game-related stuff
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

// configuration
import 'config.dart' as game_settings;

// play area
import 'components/components.dart';

class Asteroids extends FlameGame
  with HasKeyboardHandlerComponents, HasCollisionDetection {

  /*
  Asteroids()
    : super( 
      camera: CameraComponent.withFixedResolution(
        width: game_settings.gameWidth, 
        height: game_settings.gameHeight 
      ),
    );
  */

  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    world.add(Player(
      position: size / 2, 
    ));

  }

}
