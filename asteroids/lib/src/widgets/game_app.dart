import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';

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
            PlayState.background.name: (context, game) =>
              Center(
                child: Text("animating background... "),
              ),
            PlayState.mainMenu.name: (context, game) =>
              Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  Text('(definately not)',
                    style: Theme.of(context).textTheme.headlineSmall),

                  Text('ASTEROIDS',
                    style: Theme.of(context).textTheme.headlineLarge),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ 

                      // start button
                      OutlinedButton(
                        onPressed: () {}, 
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                            BorderSide(
                              color: Colors.white, 
                              width: 5.0))),
                        child: 
                          Text('start game',
                            style: Theme.of(context).textTheme.titleMedium),
                          ),

                      Text('leaderboard',
                        style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            PlayState.tutorial.name: (context, game) =>
              Center( 
                child: Text("this is the tutorial menu"),
              ),
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
