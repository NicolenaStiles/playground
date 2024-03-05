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

  final FocusNode focusNode = FocusNode(debugLabel: 'game node');
  @override 
  void initState() {
    super.initState();
    game = KeyboardExample();
    focusNode.addListener(() => print('focusNode game updated: hasFocus: ${focusNode.hasFocus}'));
    FocusScope.of(context).requestFocus(focusNode);
    instance.addListener(() => print('primary focus set to ${instance.primaryFocus}'));
    instance.addListener(() => print('focus scope set to ${instance.rootScope}'));
    print('hello ${focusNode.enclosingScope}');
    print('${instance.highlightMode}');
  }

  // taken from here:
  // https://api.flutter.dev/flutter/widgets/FocusManager/instance.html
  static FocusManager get instance => WidgetsBinding.instance.focusManager;

  @override 
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        brightness: Brightness.dark,
      ),
      home: Scaffold( 
        body: GameWidget(
          // WARN: Trying out the focus manager stuff here
          game: game,
          focusNode: focusNode,
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
