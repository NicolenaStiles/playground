import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {

  const TabHeader({ 
    super.key,
    required this.headerText,
  });

  final String headerText;
  
  @override
  Widget build(BuildContext context) {
    return Center ( 
      child: Container( 
        width: 300,
        height: 100,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          // color: Color(0x0000E5FF),
          // color: Colors.cyan,
          border: Border(
            left: BorderSide(
              color: Colors.cyan,
              width: 6,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            top: BorderSide(
              color: Colors.cyan,
              width: 6,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
        ),
        child: Align( 
          alignment: Alignment.centerLeft,
          child: Text(headerText),
        ),
      )
    );
  }
}
