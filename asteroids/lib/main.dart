import 'dart:async';
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

  int centerY = 0;
  
  @override
  AsteroidPainter(int y) {
    centerY = y;
  }

  @override
  void paint(Canvas canvas, Size size) {

    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.white;

    final rectSketch = Path();
    int rectSize = 50;

    // trying to draw a triangle
    rectSketch.moveTo(
      (size.width / 2),
      (size.height / 2) - rectSize + centerY,
      );
    rectSketch.lineTo(
      (size.width / 2) - rectSize / 2,
      (size.height / 2) + centerY,
    );
    rectSketch.lineTo(
      (size.width / 2) + rectSize / 2,
      (size.height / 2) + centerY,
    );
    rectSketch.lineTo(
      (size.width / 2),
      (size.height / 2) - rectSize + centerY,
    );

    canvas.drawPath(rectSketch, paint);

  }

  @override
  bool shouldRepaint(AsteroidPainter oldDelegate) => false;

}

class _MyHomePageState extends State<MyHomePage> {

  int _upCount = 0;
  int _downCount = 0;

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

  void _handleKeyDown(KeyEvent value) {

      setState(() {
                
        final k = value.logicalKey;

        if (value.runtimeType == KeyDownEvent) {

          if (k == LogicalKeyboardKey.arrowUp) {
            _upCount++;
          } 

          if(k == LogicalKeyboardKey.arrowDown) {
            _downCount++;
          }

        }

        if (value.runtimeType == KeyRepeatEvent) {

          if (k == LogicalKeyboardKey.arrowUp) {
            _upCount++;
          } 

          if(k == LogicalKeyboardKey.arrowDown) {
            _downCount++;
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
            _handleKeyDown(value);
          },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: Text('Press up $_upCount times!'),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: Text('Press down $_downCount times!'),
              ),
            ],
          ), 
        ),
      ),
    );
  }
}
