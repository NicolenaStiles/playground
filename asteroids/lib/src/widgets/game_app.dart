import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';
import '../theme.dart';
import 'widgets.dart';

// TODO: size literally any of this dynamically lol
class GameApp extends StatefulWidget {

  const GameApp({
    super.key,
    required this.isMobile,
  });
  final bool isMobile;
  
  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: websiteTheme,
      home: Scaffold ( 
        body: GameWidget.controlled(
          gameFactory: Asteroids.new,
          overlayBuilderMap: { 

            PlayState.mainMenu.name: (BuildContext context, Asteroids game) => 
              MainMenu(game: game),

            PlayState.leaderboard.name: (BuildContext context, Asteroids game) =>
              Leaderboard(game: game),

            PlayState.tutorial.name: (BuildContext context, Asteroids game) =>
              Tutorial(game: game),
              
            PlayState.gameOver.name: (BuildContext context, Asteroids game) =>
              GameOver(game: game),
          },
        ),
      ),
    );
  }
}
