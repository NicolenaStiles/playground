import 'package:flutter/material.dart';

import '../asteroids.dart';

class GameOver extends StatefulWidget {

  const GameOver({ 
    super.key,
    required this.game,
  });
  final Asteroids game;

  @override
  State<GameOver> createState() => _GameOverState();
}

// TODO: resize this dynamically on mobile
class _GameOverState extends State<GameOver> {

  @override 
  Widget build(BuildContext context) {
    return Center( 

    );
  }
}
