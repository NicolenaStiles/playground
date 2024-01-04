import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {

  const TabHeader({ 
    super.key,
    required this.tabHeaderText,
  });

  final String tabHeaderText;
  
  @override
  Widget build(BuildContext context) {
    return Center ( 
      child: Container( 
        decoration: const BoxDecoration(
          // color: Color(0x0000E5FF),
          // color: Colors.cyan,
          border: Border(
            left: BorderSide(
              color: Colors.cyanAccent,
              width: 6,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            top: BorderSide(
              color: Colors.cyanAccent,
              width: 6,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
        ),
        child: Align( 
          alignment: Alignment.centerLeft,
          child: Text(
            tabHeaderText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              backgroundColor: Colors.cyanAccent
            ),
          ),
        ),
      )
    );
  }
}
