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

  double _buttonPaddingInset = 0;
  TextStyle _buttonTextStyle = TextStyle();

  // have to set things here, because context is not availible in 'initState'
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Dimensions in logical pixels (dp)
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    if (width < 414) {
      _buttonTextStyle = Theme.of(context).textTheme.bodyMedium!;
      _buttonPaddingInset = 10;
    } else  {
      _buttonTextStyle = Theme.of(context).textTheme.titleMedium!;
      _buttonPaddingInset = 20;
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Center ( 
      child: Container( 
        constraints: const BoxConstraints(
          maxWidth: 512,
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
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(_buttonPaddingInset)),
                    side: const MaterialStatePropertyAll(
                      BorderSide(
                        color: Colors.white, 
                        width: 2))),
                  child: 
                    Text('play again?',
                      style: _buttonTextStyle),
                    ),

                // main menu 
                OutlinedButton(
                  onPressed: () {
                    widget.game.world.remove(widget.game.findByKeyName('scoreboard')!);
                    widget.game.world.remove(widget.game.findByKeyName('button_shoot')!);
                    widget.game.world.remove(widget.game.findByKeyName('joystick')!);
                    widget.game.playState = PlayState.mainMenu; 
                  },
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(_buttonPaddingInset)),
                    side: const MaterialStatePropertyAll(
                      BorderSide(
                        color: Colors.white, 
                        width: 2))),
                 child: 
                    Text('main menu',
                      style: _buttonTextStyle),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
