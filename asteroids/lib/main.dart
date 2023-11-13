import 'dart:async';
import 'dart:html';
import 'asteroid_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// color declarations
const Color bgColor = Color.fromARGB(255, 18, 32, 47);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Asteroids Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          ),
        debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class AsteroidPainter extends CustomPainter {

  int centerX = 0;
  int centerY = 0;
  
  @override
  AsteroidPainter(int x,int y) {
    centerX = x;
    centerY = y;
  }


  @override
  void paint(Canvas canvas, Size size) {

    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.white;

    debugPrint('$centerX,$centerY');
    AsteroidObject testObject = AsteroidObject(50, 50, [centerX,centerY], AsteroidObjectType.testSquare);
    canvas.drawPath(testObject.completePath(), paint);

  }

  @override
  bool shouldRepaint(AsteroidPainter oldDelegate) => true;

}

class _MyHomePageState extends State<MyHomePage> {

  int _x = 0;
  int _y = 0;

  var node = FocusNode();
  
  @override
  void initState() {
    node.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  void _handleKeyPress(KeyEvent value) {

      setState(() {
                
        final k = value.logicalKey;

        if (value.runtimeType == KeyDownEvent) {

          switch (k) {

            case LogicalKeyboardKey.arrowUp:
              debugPrint('PRESSED: UP');
              _y--;
            break;

            case LogicalKeyboardKey.arrowLeft:
              debugPrint('PRESSED: LEFT');
              _x--;
            break;

            case LogicalKeyboardKey.arrowRight:
              debugPrint('PRESSED: RIGHT');
              _x++;
            break;
            
            case LogicalKeyboardKey.space:
              debugPrint('PRESSED: SPACE');

            break;

            case LogicalKeyboardKey.shift:
              debugPrint('PRESSED: SHIFT');
            break;

            default:
              debugPrint('Unrecognized key!');
          }
        }

        if (value.runtimeType == KeyRepeatEvent) {

          switch (k) {

            case LogicalKeyboardKey.arrowUp:
              debugPrint('PRESSED: UP');
              debugPrint('$_y');
              _y--;
            break;

            case LogicalKeyboardKey.arrowLeft:
              debugPrint('PRESSED: LEFT');
              _x--;
            break;

            case LogicalKeyboardKey.arrowRight:
              debugPrint('PRESSED: RIGHT');
              _x++;
            break;
            
            case LogicalKeyboardKey.space:
              debugPrint('PRESSED: SPACE');
            break;

            case LogicalKeyboardKey.shift:
              debugPrint('PRESSED: SHIFT');
            break;

            default:
              debugPrint('Unrecognized key!');

          }
        }

      });
       
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: KeyboardListener(
        focusNode: node, 
        onKeyEvent: (value) { 
            _handleKeyPress(value);
          },
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: CustomPaint(painter: AsteroidPainter(500 + _x, 500 + _y))
          )
        ),
      ),
    );
  }
}
