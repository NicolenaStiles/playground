import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

// import '../asteroids.dart';
import '../mobile_asteroids.dart';
import 'components.dart';

class TestJoystick extends JoystickComponent
  with HasVisibility, TapCallbacks, HasGameRef<MobileAsteroids> {

  TestJoystick({
    required super.key,
    required super.knob,
    required super.background,
    required super.position
  });

  @override
  bool onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    game.findByKeyName<Player>('player')!.isJoystickActive = true;
    game.isJoystickActive = true;
    isVisible = true;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    game.findByKeyName<Player>('player')!.mobileMove = relativeDelta;
    game.findByKeyName<Player>('player')!.mobilePercent = intensity;
    game.findByKeyName<Player>('player')!.angleRequest = relativeDelta.screenAngle();
    return false;
  }

  @override
  void onDragStop() {
    super.onDragStop();
    game.findByKeyName<Player>('player')!.isJoystickActive = false;
    game.isJoystickActive = false;
    isVisible = false;
  }

}

/*
class VirtualJoystick extends PositionComponent 
  with HasVisibility, HasGameRef<Asteroids> {

  VirtualJoystick({ 
    required ComponentKey key,
    required this.radius,
    required super.position
  }) : super( 
    size: Vector2(radius * 2, radius * 2),
    anchor: Anchor.center,
    priority: 1,
  );

  final double radius;

  final _paintBorder = Paint() 
          ..style = PaintingStyle.stroke
          ..isAntiAlias = true
          ..strokeWidth = 5.0
          ..color = Colors.yellow;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(radius, radius), radius, _paintBorder);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add( 
      JoystickButton(
        key: ComponentKey.named('button'), 
        radius: radius / 2,
        position: size / 2));
  }
}

class JoystickButton extends CircleComponent
  with DragCallbacks, HasGameRef<Asteroids> {

  bool _isDragged = false;

  JoystickButton({ 
    required ComponentKey key,
    required super.radius,
    required super.position,
  }) : super ( 
    anchor: Anchor.center,
    priority: 2,
  );

  // init everything to zero
  double maxDist = 0;
  double dist = 0;
  double ang = 0;
  Vector2 centeredPoint = Vector2.zero();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    centeredPoint.x = radius * 2;
    centeredPoint.y = radius * 2;
    maxDist = findParent<VirtualJoystick>()!.radius;
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragged = true;
    // distance calculations
    dist = position.distanceTo(centeredPoint);
    // angle calcs
    ang = atan2(-(position.x - centeredPoint.x), -(position.y - centeredPoint.y));
    ang = (ang * radians2Degrees);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    Vector2 newPos = position + event.localDelta;
    double newAng = atan2(-(newPos.x - centeredPoint.x), 
                          -(newPos.y - centeredPoint.y));
    dist = newPos.distanceTo(centeredPoint);
    if (dist > maxDist) {
      newPos.x = maxDist * sin(newAng);
      newPos.y = maxDist * cos(newAng);
    } else {
      position = newPos;
      ang = newAng;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
    // smooooooth return to center effect
    add(
      MoveToEffect(
        centeredPoint,
        EffectController(duration: 0.1),
    ));
    dist = 0;
    ang = 0;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_isDragged) {
      paint.color = Colors.green;
    } else {
      paint.color = Colors.cyan;
    }
  }

  @override
  void update(dt) {
    super.update(dt);
    // only provide updates to the object if _isDragged == true!
  }
}
*/
