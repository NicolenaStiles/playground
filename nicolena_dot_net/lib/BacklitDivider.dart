import 'package:flutter/material.dart';

class BacklitDivider extends StatelessWidget {

  const BacklitDivider({
      super.key, 
      });

  @override
  Widget build(BuildContext context) {
    return 
      Container( 
        height: 25,
        width: 4,
        decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyan,
            blurRadius: 2,
            offset: Offset(0,0),
          ),
        ],
      ),
      child: const SizedBox(
        height: 25,
        child: VerticalDivider(color: Colors.cyan),
      ),
    );
  }

}
