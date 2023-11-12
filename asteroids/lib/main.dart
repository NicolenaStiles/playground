import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  @override
  void paint(Canvas canvas, Size size) {

    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.white;

    final rectSketch = Path();
    int rectSize = 50;

    // Left eye
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(
            (size.width / 2) - 100, 
            (size.height / 2) - 300, 
            200, 
            100
          ), Radius.circular(10)),
        paint,
      );

    // trying to draw a triangle
    rectSketch.moveTo(
      (size.width / 2),
      (size.height / 2) - rectSize
      );
    rectSketch.lineTo(
      (size.width / 2) - rectSize / 2,
      (size.height / 2) 
    );
    rectSketch.lineTo(
      (size.width / 2) + rectSize / 2,
      (size.height / 2) 
    );
    rectSketch.lineTo(
      (size.width / 2),
      (size.height / 2) - rectSize
    );

    canvas.drawPath(rectSketch, paint);

  }

  @override
  bool shouldRepaint(AsteroidPainter oldDelegate) => false;

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              color: Colors.black,
              child: CustomPaint(painter: AsteroidPainter()),
              ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton (
                    onPressed: () {}, 
                    child: const Text('Test Button 1'),
                  ),
                  TextButton (
                    onPressed: () {}, 
                    child: const Text('Test Button 2'),
                  ),
                ],
              ),
            )
          ],
        ), 
      ),
    );
  }
}
