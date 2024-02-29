import 'package:flutter/material.dart';

import 'test_game.dart';

class MainMenu extends StatefulWidget {

  const MainMenu({
    super.key,
    required this.game,
  });

  final KeyboardExample game;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late final KeyboardExample game;

  @override 
  void initState() {
    super.initState();
    game = KeyboardExample();
  }

  @override 
  Widget build(BuildContext context) {
    return Center( 
      child: Container( 
        constraints: const BoxConstraints( 
          maxWidth: 512,
        ),
        padding: const EdgeInsets.all(10),

        child: Row( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            OutlinedButton(
              onPressed: () { 
                widget.game.gameState = GameState.active;
              }, 
              child: const Text('Start Game'),
            ),

            OutlinedButton(
              onPressed: () { 
                widget.game.gameState = GameState.textBoard;
              }, 
              child: const Text('Text Board'),
            ),
          ],
        ),
      )
    );
  }
}
