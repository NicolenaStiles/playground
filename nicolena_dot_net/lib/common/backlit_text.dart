import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BacklitText extends StatefulWidget {

  const BacklitText({
    super.key, 
    this.textEntry = "",
    this.isSelectable = true,
    this.route = "",
    this.fontSize = 21,
  });

  final String textEntry;
  final bool isSelectable;
  final String route;
  final double fontSize;

  @override
  State<StatefulWidget> createState() => _BacklitTextState();

}

class _BacklitTextState extends State<BacklitText> {

  TextStyle _style = TextStyle(fontSize: 21, color: Colors.white, fontFamily: 'ProFontIIx'); 

  @override
  void initState() {
    _style = TextStyle(fontSize: widget.fontSize, color: Colors.white, fontFamily: 'ProFontIIx'); 
    super.initState();
  }

  void _assignStyle() {
    if (widget.isSelectable != true) {
      _style = TextStyle(
          shadows: [
          const Shadow(
            blurRadius: 10,
            color: Colors.cyanAccent,
            offset: Offset(0, 0),
            ),
          ],
          fontSize: widget.fontSize,
          color: Colors.cyanAccent,
          fontFamily: 'ProFontIIx',
          );

    }
  }

  void _swapStyle(bool hover) {
    setState(() {

      if (widget.isSelectable == true) {
        if (hover) {
          _style = TextStyle(
            shadows: [
            const Shadow(
              blurRadius: 10,
              color: Colors.cyan,
              offset: Offset(0, 0),
              )
            ],
            fontSize: widget.fontSize,
            color: Colors.cyan,
            fontFamily: 'ProFontIIx',
            );
        } else {
          _style = TextStyle(fontSize: widget.fontSize, color: Colors.white, fontFamily: 'ProFontIIx');
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
          padding: const EdgeInsets.all(6),

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

