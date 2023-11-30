import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BacklitText extends StatefulWidget {

  const BacklitText({
    super.key, 
    this.textEntry = "",
    this.isSelectable = true,
    this.route = "",
  });

  final String textEntry;
  final bool isSelectable;
  final String route;

  @override
  State<StatefulWidget> createState() =>  _BacklitTextState();

}

class _BacklitTextState extends State<BacklitText> {

  TextStyle _style = const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'ProFontIIx'); 

  void _assignStyle() {
    if (widget.isSelectable != true) {
      _style = const TextStyle(
          shadows: [
          Shadow(
            blurRadius: 10,
            color: Colors.cyanAccent,
            offset: Offset(0, 0),
            ),
          ],
          fontSize: 18,
          color: Colors.cyanAccent,
          fontFamily: 'ProFontIIx',
          );

    }
  }

  void _swapStyle(bool hover) {
    setState(() {

      if (widget.isSelectable == true) {
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
      }
    
    });
  }

  @override 
  Widget build(BuildContext context) {
    _assignStyle();
    return(
      MouseRegion(
        onEnter: (_) {                      
          if (widget.isSelectable) {
            _swapStyle(true);
          }
        },

        onExit: (_) {
          if (widget.isSelectable) {
            _swapStyle(false);
          }
        },

        child: Container( 

          color: Colors.transparent,
          alignment: Alignment.center,
          width: 200,
          height: 50,

          child: TextButton( 
            onPressed: () {
              context.go(widget.route);
            },
            // disabling "splash effects"
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>( 
                (Set<MaterialState> states) {
                  return Colors.transparent;
                },
              ),
              splashFactory: NoSplash.splashFactory,
            ),

            // actual button text setup
            child: Text(
              widget.textEntry,
              style: _style,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    );
  }
}
