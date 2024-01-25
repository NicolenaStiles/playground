import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class PlayArea extends RectangleComponent 
  with HasGameReference<Asteroids> {

  PlayArea()
    : super( 
      paint: Paint()..color = Colors.black,
      children: [RectangleHitbox()],
    );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    // TODO: change padding here (currently magic number 50) 
    // this is just some arbitrary shit. 
    size = Vector2(game.width + 50, game.height + 50);
  }


}
