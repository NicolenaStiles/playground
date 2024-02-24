import 'package:flutter/material.dart';

import '../api/site_state.dart';

import '../asteroids.dart';

class Tutorial extends StatefulWidget {

  const Tutorial({ 
    super.key,
  });

  @override
  State<Tutorial> createState() => _TutorialState();
}

// TODO: load in ship, scoreboard, and lives during tutorial
class _TutorialState extends State<Tutorial> {

  var _tutorialText = "";
  var _tutorialStartText = "";

  final _desktopTutorialText = """Use WAD to steer the spaceship and SPACEBAR to shoot. Colliding with an asteroid will cost you a life. Be careful, since you only have three! Try to make it as high as you can on the leaderboard, but watch out: I've heard we're not alone in space...""";
  final _desktopStartText = "Press SPACE to start!";

  final _mobileTutorialText = "Tap anywhere to bring up the virtual joystick and steer the ship. Tap or hold the cyan button in the bottom left to shoot. Colliding with an asteroid will cost you a life. Be careful, since you only have three! Try to make it as high as you can on the leaderboard, but watch out: I've heard we're not alone in space...";
  final _mobileStartText = "Tap to start!";

  TextStyle _tutorialTextStyle = const TextStyle();
  MainAxisAlignment _setAlignment = MainAxisAlignment.end;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Dimensions in logical pixels (dp)
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    if (getIt<SiteState>().isMobile) {
      _setAlignment = MainAxisAlignment.center;
      _tutorialText = _mobileTutorialText;
      _tutorialStartText = _mobileStartText;
    } else {
      _setAlignment = MainAxisAlignment.end;
      _tutorialText = _desktopTutorialText;
      _tutorialStartText = _desktopStartText;
    }

    if (width < 414) {
      _tutorialTextStyle = Theme.of(context).textTheme.bodySmall!;
    } else  {
      _tutorialTextStyle = Theme.of(context).textTheme.titleMedium!;
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Center( 
      child: Column( 
        mainAxisAlignment: _setAlignment,
        children: [ 
           Container( 
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
            child: Center(
              child: Column( 
                children: [
                  Text(_tutorialText,
                    style: _tutorialTextStyle),

                  Text(_tutorialStartText,
                    style: _tutorialTextStyle),
                ],
              ),
            ),
          ),
        ], 
      ),
    );
  }
}
