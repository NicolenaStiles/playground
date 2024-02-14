import 'package:flutter/material.dart';

import '../asteroids.dart';

class Tutorial extends StatefulWidget {

  const Tutorial({ 
    super.key,
    required this.game,
  });
  final Asteroids game;

  @override
  State<Tutorial> createState() => _TutorialState();
}

// TODO: resize this dynamically on mobile
class _TutorialState extends State<Tutorial> {

  @override 
  Widget build(BuildContext context) {
    return Center( 
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.end,
        children: [ 
          Container( 
            constraints: const BoxConstraints(
              maxHeight: 256,
            ),
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.9),
              shape: const ContinuousRectangleBorder(
                side: BorderSide(
                  color: Colors.white, 
                  width: 2)),
            ),
            child: Center( 
              child: Text('This is some tutorial text',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
        ], 
      ),
    );
  }
}
