import 'package:flutter/material.dart';

class BodyBorder extends StatelessWidget {

  const BodyBorder({ 
    super.key,
    required this.content,
  });

  final Widget? content;

  @override
  Widget build(BuildContext context) {

    return Container( 
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 6,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFF00E5FF),
          ),
        ),
      ),
      child: content,
    );
  }
}
