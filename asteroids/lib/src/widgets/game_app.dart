import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';
import '../theme.dart';
import 'widgets.dart';

// TODO: size literally any of this dynamically lol
class GameApp extends StatefulWidget {

  const GameApp({
    super.key,
  });
  
  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {

  late final Asteroids game;

  @override
  void initState() {
    super.initState();
    game = Asteroids();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: websiteTheme,
      home: Scaffold ( 
        body: GameWidget(
          game: game,
          overlayBuilderMap: { 

            PlayState.mainMenu.name: (BuildContext context, Asteroids game) => 
              MainMenu(game: game),

            PlayState.leaderboard.name: (BuildContext context, Asteroids game) =>
              LeaderboardDisplay(game: game),

            PlayState.tutorial.name: (BuildContext context, Asteroids game) =>
              const Tutorial(),
              
            PlayState.gameOver.name: (BuildContext context, Asteroids game) =>
              GameOver(game: game),

            PlayState.addScore.name: (BuildContext context, Asteroids game) =>
              AddScore(game: game),
          },
        ),
      ),
    );
  }
}
