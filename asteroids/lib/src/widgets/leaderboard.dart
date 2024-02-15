import 'package:flutter/material.dart';

import '../asteroids.dart';

// TODO: add leaderboard
// TODO: resize this dynamically on mobile
class Leaderboard extends StatefulWidget {

  const Leaderboard({ 
    super.key,
    required this.game,
  });
  final Asteroids game;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  double _buttonPaddingInset = 0;
  TextStyle _buttonTextStyle = const TextStyle();

  // have to set things here, because context is not availible in 'initState'
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Dimensions in logical pixels (dp)
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    if (width < 414) {
      _buttonTextStyle = Theme.of(context).textTheme.bodySmall!;
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
          minWidth: 375,
          maxWidth: 1024,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: Colors.black.withOpacity(0.75),
          shape: const ContinuousRectangleBorder(
            side: BorderSide(
              color: Colors.white, 
              width: 2))),
        child: Align( 
          alignment: Alignment.topLeft,
          child: OutlinedButton(
            onPressed: () {
              widget.game.playState = PlayState.mainMenu; 
            },
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(_buttonPaddingInset)),
              side: const MaterialStatePropertyAll(
                BorderSide(
                  color: Colors.white, 
                  width: 2))),
            child: 
              Text('<',
                style: _buttonTextStyle),
          ),
        ),
      ),
    );
  }
}
