import 'package:flutter/material.dart';

class CoreBorder extends StatelessWidget {

  const CoreBorder({ 
    super.key,
    required this.content,
  });

  final Widget? content;

  @override
  Widget build(BuildContext context) {

      return Center( 
        child: Container( 
          constraints: const BoxConstraints(minWidth: 375, maxWidth: 1024),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: ShapeDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: const RoundedRectangleBorder( 
              side: BorderSide(width: 2, color: Color(0xFF00B8D4)),
            )
          ),
        child: Center (
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0),
              shape: const RoundedRectangleBorder( 
                side: BorderSide(width: 2, color: Color(0xFF00E5FF)),
              ),
            ),
            child: Container ( 
              padding: const EdgeInsets.all(6),
              child: content,
            ),
          ),
        ), 
        ),
    );

  }
}
