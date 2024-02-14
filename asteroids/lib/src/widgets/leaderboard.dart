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

  @override 
  Widget build(BuildContext context) {
    return Center ( 
      child: Container( 
        constraints: const BoxConstraints(
          minWidth: 375,
          maxWidth: 512,
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
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: Colors.white, 
                  width: 2))),
            child: 
              Text('<',
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
      ),
    );
  }
}
