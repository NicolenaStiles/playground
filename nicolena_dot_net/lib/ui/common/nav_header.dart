import 'package:flutter/material.dart';
import 'backlit_text.dart';
import 'backlit_divider.dart';

class NavHeader extends StatelessWidget { 

  const NavHeader ({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {

    return Container( 

      padding: const EdgeInsets.all(4),
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
          right: BorderSide(
            color: Colors.cyan,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          bottom: BorderSide(
            color: Colors.cyan,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      ),

      child: const Row( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          Align(
            alignment: Alignment.centerLeft,
            child: BacklitText(textEntry: 'NICOLENA DOT NET',
                               fontSize: 32,
                               isSelectable: true,
                               route: '/'),
          ),

          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              BacklitText(textEntry: 'ABOUT', 
                          fontSize: 18,
                          isSelectable: true,
                          route: '/about'),

              BacklitDivider(),

              BacklitText(textEntry: 'BLOG', 
                          fontSize: 18,
                          isSelectable: true,
                          route: '/blog'),

              BacklitDivider(),

              BacklitText(textEntry: 'CONTACT', 
                          fontSize: 18,
                          isSelectable: true,
                          route: '/contact'),

            ],
          ),

        ],

      ),
      
    );
  }

}
