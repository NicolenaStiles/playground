// flame-specific
import 'package:flame/components.dart';

// flutter-specific
import 'package:flutter/material.dart';

// local components 
import '../asteroids.dart';

class Lives extends PositionComponent
  with HasGameRef<Asteroids> {

  // Rendering
  var _graphicPath = Path();
  List<List<double>> _verticies = [];
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.white;
  
  Lives({ 
    required super.key,
    required super.size,
    required super.position,
  }) : super ( 
    anchor: Anchor.center,
  ){ 
    _graphicPath = completePath();
  }

  @override 
  Future<void> onLoad() async {
    super.onLoad();
    _graphicPath = completePath();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPath(_graphicPath, _paint);
  }

  Path completePath() {

    _verticies = [];
    final graphicPath = Path();

    // A
    _verticies.add([ width * 0.5, 0]);
    // B
    _verticies.add([ width, height]);
    // C
    _verticies.add([ (width * 0.8), (height * 0.8) ]);
    // D
    _verticies.add([ (width * 0.2), (height * 0.8) ]);
    // E
    _verticies.add([ 0 , height]);

    graphicPath.moveTo(_verticies[0][0], _verticies[0][1]);
    for(int v = 1; v < _verticies.length; v++) {
      graphicPath.lineTo(_verticies[v][0], _verticies[v][1]);
    }
    graphicPath.lineTo(_verticies[0][0], _verticies[0][1]);

    return graphicPath;
  }

}
