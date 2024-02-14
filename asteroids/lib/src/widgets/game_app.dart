import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';
import '../widgets/main_menu.dart';
import '../widgets/tutorial.dart';

import '../theme.dart';

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

            PlayState.tutorial.name: (BuildContext context, Asteroids game) =>
              Tutorial(game: game),
              
            PlayState.gameOver.name: (context, game) =>
              Center( 
                child: Text("this is the game over screen"),
              ),
          },
        ),
      ),
    );
  }
}
