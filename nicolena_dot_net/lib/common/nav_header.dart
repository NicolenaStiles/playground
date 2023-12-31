import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BacklitDivider extends StatelessWidget {

  const BacklitDivider({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return 
      Container( 
        height: 25,
        width: 4,
        decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyan,
            blurRadius: 2,
            offset: Offset(0,0),
          ),
        ],
      ),
      child: const SizedBox(
        height: 25,
        child: VerticalDivider(color: Colors.cyan),
      ),
    );
  }

}

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

class NavHeader extends StatelessWidget { 

  const NavHeader ({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {

    return Container( 

      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: Colors.black.withOpacity(1),
        shape: const RoundedRectangleBorder( 
          side: BorderSide(width: 2, color: Color(0xFF00B8D4)),
        )
      ),

      child: const Row( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
            Align(
              alignment: Alignment.centerLeft,
              child: BacklitText(textEntry: 'NICOLENA DOT NET',
                                 fontSize: 32,
                                 isSelectable: true,
                                 route: '/home'),
            ),

          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              BacklitText(textEntry: 'ABOUT', 
                          fontSize: 18,
                          isSelectable: true,
                          route: '/about'),

              BacklitDivider(),

              BacklitText(textEntry: 'BLOG', 
                          fontSize: 18,
                          isSelectable: true,
                          route: '/blog'),

              BacklitDivider(),

              BacklitText(textEntry: 'CONTACT', 
                          fontSize: 18,
                          isSelectable: true,
                          route: '/contact'),

            ],
          ),

        ],

      ),
      
    );
  }

}
