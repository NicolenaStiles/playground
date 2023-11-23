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

  TextStyle _style = const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'ProFontIIx', fontWeight: FontWeight.w100);

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
          fontFamily: 'ProFontIIx',
          );
      } else {
        _style = const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'ProFontIIx');
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
          color: Colors.transparent,
          alignment: Alignment.center,
          width: 200,
          height: 50,

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
