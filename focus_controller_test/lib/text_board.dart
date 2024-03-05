import 'package:flutter/material.dart';

import 'test_game.dart';

class TextBoard extends StatefulWidget {

  const TextBoard({
    super.key,
    required this.game,
  });

  final KeyboardExample game;


  @override
  State<TextBoard> createState() => _TextBoardState();
}

class _TextBoardState extends State<TextBoard> {

  late final KeyboardExample game;
  List<String> textEntries = [];
  String _textInput = "";

  final FocusNode focusNode = FocusNode(debugLabel: 'text entry node');
  @override 
  void initState() {
    super.initState();
    game = KeyboardExample();
    focusNode.addListener(() => print('focusNode textfield updated: hasFocus: ${focusNode.hasFocus}'));
  }

  @override
  void dispose() {
    focusNode.dispose();
    FocusScope.of(context).dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Center( 
      child: Container( 
        constraints: const BoxConstraints( 
          maxWidth: 512,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        child: Column( 
          children: [
            
            // Back Button
            // PERF: This is absolutely fine
            Align( 
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: () {
                  widget.game.gameState = GameState.mainMenu;
                  Focus.of(context).unfocus();
                },
                child: const Text('<'),
              )
            ),
            
            // Text Entry Collection 
            // PERF: I think this is also totally fine
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: textEntries.length,
              itemBuilder: (BuildContext context, index) {
                return Text(textEntries[index]);
              },
              separatorBuilder: (BuildContext context, int index) => Divider( 
                color: Colors.white.withOpacity(0),
              ), 
            ),

            // Text entry field and submission button
            Row( 
              children: [
  
                Expanded( 

                  // WARN: testing focus management stuff 
                    child: TextField(
                      // properties
                      autofocus: false,
                      focusNode: focusNode,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(focusNode);
                      },
                      // update value 
                      onChanged: (inputValue) {
                        _textInput = inputValue;
                      },
                    ),
                ),

                OutlinedButton(
                  onPressed: () {
                    if (_textInput.isNotEmpty) { 
                      setState(() => textEntries.add(_textInput));
                      _textInput = "";
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
