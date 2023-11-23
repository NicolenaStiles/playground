
import 'package:flutter/material.dart';

void main() {
  runApp(const NicolenaDotNet());
}

class NicolenaDotNet extends StatelessWidget {
  const NicolenaDotNet({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Nicolena Dot Net',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Nicolena\'s landing page'),
      // get rid of debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextStyle _defaultStyle = TextStyle(fontSize: 18, color: Colors.white);
  TextStyle _hoverStyle = TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.cyan,
                                offset: Offset(5, 5),
                              )
                            ],
                            fontSize: 18,
                            color: Colors.cyan,
                          );

  TextStyle _style1 = TextStyle(fontSize: 18, color: Colors.white);
  TextStyle _style2 = TextStyle(fontSize: 18, color: Colors.white);
  TextStyle _style3 = TextStyle(fontSize: 18, color: Colors.white);

  void _changeStyle(bool _isHover, int idx) {
    setState(() {

        if (_isHover == true) {

          switch (idx) {

            case 1:
            _style1 = const TextStyle(
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
            break;

            case 2:
            _style2 = const TextStyle(
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
            break;

            case 3:
            _style3 = const TextStyle(
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
            break;

            default:
        }
      } else {

        switch (idx) {

            case 1:
            _style1 = const TextStyle(fontSize: 18, color: Colors.white);
            break;

            case 2:
            _style2 =  const TextStyle(fontSize: 18, color: Colors.white);          
            break;

            case 3:
            _style3 = const TextStyle(fontSize: 18, color: Colors.white);
            break;

            default:
          }
      }

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                MouseRegion(
                    onEnter: (_) {                      
                      _changeStyle(true, 1);
                    },

                    onExit: (_) {
                      _changeStyle(false, 1);
                    },

                    child: Container( 
                      color: Colors.black,
                      alignment: Alignment.center,
                      width: 300,
                      height: 100,

                      child: Text( 
                        'About',
                        style: _style1,
                        textAlign: TextAlign.center,
                      )
                    ),
                ),

                Container(
                  height: 80,
                  child: VerticalDivider(color: Colors.lime),
                ),

                MouseRegion(
                    onEnter: (_) {                      
                      _changeStyle(true, 2);
                    },

                    onExit: (_) {
                      _changeStyle(false, 2);
                    },

                    child: Container( 
                      color: Colors.black,
                      alignment: Alignment.center,
                      width: 300,
                      height: 100,

                      child: Text( 
                        'Blog',
                        style: _style2,
                        textAlign: TextAlign.center,
                      )
                    ),
                ),

                Container(
                  height: 80,
                  child: VerticalDivider(color: Colors.lime),
                ),

                MouseRegion(
                    onEnter: (_) {                      
                      _changeStyle(true, 3);
                    },

                    onExit: (_) {
                      _changeStyle(false, 3);
                    },

                    child: Container( 
                      color: Colors.black,
                      alignment: Alignment.center,
                      width: 300,
                      height: 100,

                      child: Text( 
                        'Contact',
                        style: _style3,
                        textAlign: TextAlign.center,
                      )
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
