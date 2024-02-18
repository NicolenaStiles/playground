import 'package:flutter/material.dart';

import '../asteroids.dart';

// global state management
import '../api/site_state.dart';

// for each high score entry
import 'leaderboard_entry.dart';

// TODO: index from 1 in display
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
        child: Column( 
          children: [ 

            // Back button
            Align( 
              alignment: Alignment.centerLeft,
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

            // High score header
            Text('HIGH SCORES',
              style: Theme.of(context).textTheme.headlineSmall),

            // High score collection
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: getIt<SiteState>().highScores.length,
              itemBuilder: (BuildContext context, index) {
                  return LeaderboardEntry(
                    idx: index, 
                    score: getIt<SiteState>().highScores[index].$1,
                    initials: getIt<SiteState>().highScores[index].$2,
                  );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                // TODO: fix this, it's such a hack omg
                color: Colors.white.withOpacity(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
