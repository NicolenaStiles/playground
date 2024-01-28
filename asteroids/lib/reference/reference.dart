import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'asteroid_object.dart';
import 'package:flame/input.dart';
import 'dart:math';

List<AsteroidObject> renderTestGraphics() {
  List<AsteroidObject> renderObjects = [];
  return renderObjects;
}

// TODO: better understand world vs canvas vs size
class Asteroids extends FlameGame 
  with HasKeyboardHandlerComponents, HasCollisionDetection {

  // constants
  // player
  static const int _playerSpeed = 200;
  static const int _rotationSpeed = 3;

  // asteroid
  static const int _asteroidSpeed = 200;

  // shots
  static const int _shotSpeed = 600;
  int _currShotDelay = 0;
  static const int _shotDelay = 30;
  bool _shotReady = true;

  // bodies on screen @ start
  late final AsteroidObject player;
  late final AsteroidObject testAsteroid;
  late final AsteroidObject testShot;
  //List<AsteroidObject> asteroids = [];

  // direction info for bodies
  final Vector2 _direction = Vector2.zero();
  final Vector2 _directionAsteroid = Vector2.zero();
  final Vector2 _directionShot = Vector2.zero();

  final Map<LogicalKeyboardKey, double> _keyWeights = {
    LogicalKeyboardKey.keyA: 0,
    LogicalKeyboardKey.keyD: 0,
    LogicalKeyboardKey.keyW: 0,
    LogicalKeyboardKey.space: 0,
  };

  @override
  Future<void> onLoad() async {

    await super.onLoad();

    // player ship
    player = AsteroidObject(AsteroidObjectType.playerShip)
      ..position = Vector2(size.x * 0.5, size.y * 0.5)
      ..width = 36
      ..height = 60
      ..anchor = Anchor.center;

    player.add(RectangleHitbox());
    add(player);

    // test asteroid array
    /*
    for (double i = 0.2; i < 1; i = i + 0.2) {
      asteroids.add(
        AsteroidObject(AsteroidObjectType.asteroidS) 
        ..position = Vector2(size.x * i, 0)
        ..width = 32
        ..height = 32
        ..anchor = Anchor.center
      );
      asteroids.last.add(RectangleHitbox(isSolid: true));
    }
    addAll(asteroids);
    */

    testAsteroid = AsteroidObject(AsteroidObjectType.asteroidO) 
      ..position = Vector2(size.x * 0.5, size.y * 0.25)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;

    testAsteroid.add(RectangleHitbox(isSolid: true));
    add(testAsteroid);

    // test shot
    // doesn't get added until relevant!
    testShot = AsteroidObject(AsteroidObjectType.shot)
      ..position = Vector2(0,0)
      ..width = 2
      ..height = 2
      ..anchor = Anchor.center;
    testShot.add(RectangleHitbox(isSolid: true));

    // add keyboard handling to game
    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, false),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, false),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, false),
          LogicalKeyboardKey.space: (keys) =>
              _handleKey(LogicalKeyboardKey.space, false),
        },
        keyDown: {
          LogicalKeyboardKey.keyA: (keys) =>
              _handleKey(LogicalKeyboardKey.keyA, true),
          LogicalKeyboardKey.keyD: (keys) =>
              _handleKey(LogicalKeyboardKey.keyD, true),
          LogicalKeyboardKey.keyW: (keys) =>
              _handleKey(LogicalKeyboardKey.keyW, true),
          LogicalKeyboardKey.space: (keys) =>
              _handleKey(LogicalKeyboardKey.space, true),
        },
      ),
    );
  }


  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  void update(double dt) {

    super.update(dt);

    // for player ship
    handlePlayerMovement(dt);
    checkWraparound(player);

    // for user firing shot
    handleShot(dt);
    checkWraparound(testShot);


    /*
    if (!contains(testAsteroid)) {

      int randX = random(0, canvasSize.x.toInt());
      int randY = random(0, canvasSize.y.toInt());
      testAsteroid.position = Vector2(randX.toDouble(), 0);
      print("${testAsteroid.position}");
      add(testAsteroid);

    } else {

      _directionAsteroid
        ..setValues(0,1)
        ..normalize();

      final displacementAsteroid = _directionAsteroid * (_asteroidSpeed * dt);
      testAsteroid.position.add(displacementAsteroid);

      checkWraparound(testAsteroid);

    }
    */

    /*
    for (var rock in asteroids) {
      _directionAsteroid
        ..setValues(0,1)
        ..normalize();
      rock.position.add(_directionAsteroid * (_asteroidSpeed * dt));
      checkWraparound(rock);
    }
    */

    // for asteroid
    // position update
    /*
    _directionAsteroid
      ..setValues(0,1)
      ..normalize();

    final displacementAsteroid = _directionAsteroid * (_asteroidSpeed * dt);
    testAsteroid.position.add(displacementAsteroid);

    checkWraparound(testAsteroid);
    */

  }

  void handlePlayerMovement(double dt) {
    // rotation update
    player.angle += rInput * (_rotationSpeed * dt);
    player.angle %= 2 * pi;

    // movement update
    double xInput = forwardMovement * sin(player.angle);
    double yInput = forwardMovement * (0 - cos(player.angle));

    _direction
      ..setValues(xInput, yInput)
      ..normalize();

    final displacement = _direction * (_playerSpeed * dt);
    player.position.add(displacement);
  }

  void handleShot(double dt) {

    // Check if player can fire shot
    if (_shotReady == true && (fireShot == 1)) {
        print("Shot fired!");
        for (var e in children) {
          if (e is AsteroidObject) {
            print(e.objType);
          }
        }
        // create shot object
        double shotPositionX = (player.position.x + sin(player.angle) * (player.height / 2));
        double shotPositionY = (player.position.y - cos(player.angle) * (player.height / 2));
        testShot          
          ..position = Vector2(shotPositionX,shotPositionY)
          ..width = 2
          ..height = 2
          ..anchor = Anchor.center;
        add(testShot);
        testShot.angle = player.angle;
        _shotReady = false;
    } else if (!_shotReady) {
      if (_currShotDelay < _shotDelay) {
        _currShotDelay++;
      } else {
        _shotReady = true;
        _currShotDelay = 0;
        if(contains(testShot)) {
          remove(testShot);
        }
      }
    }

    if (contains(testShot)) {
      // movement update
      _directionShot
        ..setValues(sin(testShot.angle), 0 - cos(testShot.angle))
        ..normalize();

      final displacementShot = _directionShot * (_shotSpeed * dt);
      testShot.position.add(displacementShot);
    }
  }


  bool _handleKey(LogicalKeyboardKey key, bool isDown) {
    _keyWeights[key] = isDown ? 1 : 0;
    return true;
  }

  // rotational input: uses keys D and A
  double get rInput =>
    _keyWeights[LogicalKeyboardKey.keyD]! -
    _keyWeights[LogicalKeyboardKey.keyA]!;

  // forward movement: uses W
  double get forwardMovement =>
    _keyWeights[LogicalKeyboardKey.keyW]!;

  // fire shot: uses spacebar
  double get fireShot =>
    _keyWeights[LogicalKeyboardKey.space]!;

  // checks if an asteroid object is out-of-bounds and warps it if it is
  void checkWraparound(AsteroidObject checkObj) {
     // wrapping around the screen: horizontal
    if (checkObj.position.x > (canvasSize.x + checkObj.width)) {
      checkObj.position.x = 0 - checkObj.width / 2;
    } else if ((checkObj.position.x + checkObj.width) < 0) {
      checkObj.position.x = canvasSize.x + checkObj.width / 2;
    }
    // wrapping around the screen: vertical 
    if (checkObj.position.y > (canvasSize.y + checkObj.width)) {
      checkObj.position.y = 0 - (checkObj.height / 2);
    } else if ((checkObj.position.y + checkObj.width) < 0) {
      checkObj.position.y = canvasSize.y - (checkObj.height / 2);
    }
  }

  // just to test all the assets and make sure sizes/proportions work
  void renderTestGraphics() {

    // player ship
    AsteroidObject player = AsteroidObject(AsteroidObjectType.playerShip)
      ..position = Vector2(size.x * 0.2, size.y * 0.25)
      ..width = 36
      ..height = 60
      ..anchor = Anchor.center;

    // alien ship
    AsteroidObject alien = AsteroidObject(AsteroidObjectType.alienShip)
      ..position = Vector2(size.x * 0.2, size.y * 0.5)
      ..width = 72 
      ..height = 60 
      ..anchor = Anchor.center;

    // shot 
    AsteroidObject shot = AsteroidObject(AsteroidObjectType.shot)
      ..position = Vector2(size.x * 0.2, size.y * 0.75)
      ..width = 2
      ..height = 2
      ..anchor = Anchor.center;

    // asteroid X-shape
    // small
    AsteroidObject smallX = AsteroidObject(AsteroidObjectType.asteroidX)
      ..position = Vector2(size.x * 0.4, size.y * 0.3)
      ..width = 64 
      ..height = 64 
      ..anchor = Anchor.center;
  
    // medium
    AsteroidObject medX = AsteroidObject(AsteroidObjectType.asteroidX)
      ..position = Vector2(size.x * 0.4, size.y * 0.5)
      ..width = 96
      ..height = 96
      ..anchor = Anchor.center;
    
    // large
    AsteroidObject largeX = AsteroidObject(AsteroidObjectType.asteroidX)
      ..position = Vector2(size.x * 0.4, size.y * 0.7)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;

    // asteroid S-shape
    // small
    AsteroidObject smallS = AsteroidObject(AsteroidObjectType.asteroidS)
      ..position = Vector2(size.x * 0.6, size.y * 0.3)
      ..width = 64 
      ..height = 64 
      ..anchor = Anchor.center;

    // medium
    AsteroidObject medS = AsteroidObject(AsteroidObjectType.asteroidS)
      ..position = Vector2(size.x * 0.6, size.y * 0.5)
      ..width = 96
      ..height = 96
      ..anchor = Anchor.center;
    
    // large
    AsteroidObject largeS = AsteroidObject(AsteroidObjectType.asteroidS)
      ..position = Vector2(size.x * 0.6, size.y * 0.7)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;

    // asteroid O-shape
    // small
    AsteroidObject smallO = AsteroidObject(AsteroidObjectType.asteroidO)
      ..position = Vector2(size.x * 0.8, size.y * 0.3)
      ..width = 64 
      ..height = 64 
      ..anchor = Anchor.center;

    // medium
    AsteroidObject medO = AsteroidObject(AsteroidObjectType.asteroidO)
      ..position = Vector2(size.x * 0.8, size.y * 0.5)
      ..width = 96
      ..height = 96
      ..anchor = Anchor.center;
    
    // large
    AsteroidObject largeO = AsteroidObject(AsteroidObjectType.asteroidO)
      ..position = Vector2(size.x * 0.8, size.y * 0.7)
      ..width = 128
      ..height = 128
      ..anchor = Anchor.center;

    addAll([player,
    alien,
    shot,
    smallX,medX,largeX,
    smallS,medS,largeS,
    smallO,medO,largeO,
    ]);
  }
} 


/*
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
*/
