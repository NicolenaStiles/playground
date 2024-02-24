import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../asteroids.dart';

// global state management
import '../api/site_state.dart';

class GameOverAddScore extends StatefulWidget {

  const GameOverAddScore({ 
    super.key,
    required this.game,
  });
  final Asteroids game;

  @override
  State<GameOverAddScore> createState() => _GameOverAddScoreState();
}

// TODO: Cleanup form handling (low priority tho)
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}

class _GameOverAddScoreState extends State<GameOverAddScore> {

  // Text form handling
  String _initalInput = "";
  RegExp initalValidator = RegExp(r'[a-zA-Z]');
  bool isValidInitals = false;

  void setValidator(valid){
    setState(() {
      isValidInitals = valid;
    });
  }

  // Text form sizing
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
             
            // Game over text
            Column( 
              mainAxisSize: MainAxisSize.min,
              children: [ 
              Text('GAME OVER', 
                style: Theme.of(context).textTheme.headlineLarge),

              Text('Your score of ${widget.game.score} is one of the ten best. Please enter your initals below:',
                style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),

            Center( 
              child: TextField(
                maxLines: 1,
                maxLength: 3,

                textCapitalization: TextCapitalization.characters,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!,

                inputFormatters: [ 
                  FilteringTextInputFormatter.allow(initalValidator),
                  UpperCaseTextFormatter(), 
                ],

                onChanged: (inputValue) {
                  if (inputValue.isEmpty || initalValidator.hasMatch(inputValue)) {
                    setValidator(true);
                    _initalInput = inputValue.toUpperCase(); 
                  } else {
                    setValidator(false);
                  }
                },

                decoration: InputDecoration( 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  errorText: isValidInitals ? null : 'C\'mon now. Enter at least one inital.' 
                ),
              ),
            ),

            OutlinedButton(
              onPressed: () {
                if (isValidInitals) {
                  _initalInput.toUpperCase();
                  getIt<Leaderboard>().handleScore(
                    LeaderboardEntry(
                      score: widget.game.score, 
                      initals: _initalInput));
                  widget.game.playState = PlayState.gameOver;
                }
              },
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(_buttonPaddingInset)),
                side: const MaterialStatePropertyAll(
                  BorderSide(
                    color: Colors.white, 
                    width: 2))),
              child: 
                Text('SUBMIT',
                  style: _buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
