import 'package:flutter/material.dart';

import '../theme.dart';
import '../common/backlit_text.dart';
import '../common/backlit_divider.dart';

class HomepageScreen extends StatelessWidget {

  const HomepageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold( 
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Text(
            'NICOLENA DOT NET',
            style: TextStyle(fontSize: 36),

          ),


          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              BacklitText(textEntry: 'ABOUT', 
                          fontSize: 24,
                          isSelectable: true,
                          route: '/about'),

              BacklitDivider(),

              BacklitText(textEntry: 'BLOG', 
                          fontSize: 24,
                          isSelectable: true,
                          route: '/blog'),

              BacklitDivider(),

              BacklitText(textEntry: 'CONTACT', 
                          fontSize: 24,
                          isSelectable: true,
                          route: '/contact'),

            ],
          ),
          ],
        ),
      ),

    );
  }
}
