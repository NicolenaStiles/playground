import 'package:focus_controller_test/main_menu.dart';
import 'package:focus_controller_test/text_board.dart';

import 'test_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final KeyboardExample game;

  @override 
  void initState() {
    super.initState();
    game = KeyboardExample();
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        brightness: Brightness.dark,
      ),
      home: Scaffold( 
        body: GameWidget(
          game: game,
          overlayBuilderMap: { 

            GameState.mainMenu.name: (BuildContext context, KeyboardExample game) =>
              MainMenu(game: game),

            GameState.textBoard.name: (BuildContext context, KeyboardExample game) =>
              TextBoard(game: game),

          },
        ),
      ),
    );
  }
}
