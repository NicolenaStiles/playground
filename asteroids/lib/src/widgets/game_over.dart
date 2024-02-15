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
    return Center ( 
      child: Container( 
        constraints: const BoxConstraints(
          minWidth: 375,
          maxWidth: 512,
          minHeight: 375,
          maxHeight: 512,
        ),
        padding: const EdgeInsets.all(10),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
    
              Column( 
                mainAxisSize: MainAxisSize.min,
                children: [ 
                Text('GAME OVER', 
                  style: Theme.of(context).textTheme.headlineLarge),

                Text('final score: ${widget.game.score}',
                  style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 

                // replay 
                OutlinedButton(
                  onPressed: () {
                    widget.game.playState = PlayState.replay; 
                  },
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Colors.white, 
                        width: 2))),
                  child: 
                    Text('play again?',
                      style: Theme.of(context).textTheme.titleMedium),
                    ),

                // main menu 
                OutlinedButton(
                  onPressed: () {
                    //widget.game.world.remove(widget.game.findByKeyName('scoreboard')!);
                    widget.game.playState = PlayState.mainMenu; 
                  },
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Colors.white, 
                        width: 2))),
                  child: 
                    Text('main menu',
                      style: Theme.of(context).textTheme.titleMedium),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
