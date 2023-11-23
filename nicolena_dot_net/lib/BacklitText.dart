import 'package:flutter/material.dart';

class BacklitText extends StatefulWidget {

  const BacklitText({
    super.key, 
    this.textEntry = "",
  });

  final String textEntry;

  @override
  State<StatefulWidget> createState() =>  _BacklitTextState();

}

class _BacklitTextState extends State<BacklitText> {

  TextStyle _style = const TextStyle(fontSize: 18, color: Colors.white);

  void _swapStyle(bool hover) {
    setState(() {
      if (hover) {
      _style = const TextStyle(
          shadows: [
          Shadow(
            blurRadius: 10,
            color: Colors.cyan,
            offset: Offset(0, 0),
            )
          ],
          fontSize: 18,
          color: Colors.cyan,
          );
      } else {
        _style = const TextStyle(fontSize: 18, color: Colors.white);
      }
    });
  }

  @override 
    Widget build(BuildContext context) {
      return(
        MouseRegion(
          onEnter: (_) {                      
            _swapStyle(true);
          },

          onExit: (_) {
            _swapStyle(false);
          },

          child: Container( 
          color: Colors.black,
          alignment: Alignment.center,
          width: 300,
          height: 100,

          child: Text( 
            widget.textEntry,
            style: _style,
            textAlign: TextAlign.center,
            )
          ),
        )
    );
  }
}
