import 'package:flutter/material.dart';

import '../asteroids.dart';

class Leaderboard extends StatefulWidget {

  const Leaderboard({ 
    super.key,
    required this.game,
  });
  final Asteroids game;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

// TODO: add leaderboard
// TODO: resize this dynamically on mobile
class _LeaderboardState extends State<Leaderboard> {

  @override 
  Widget build(BuildContext context) {
    return Center( 

    );
  }
}
